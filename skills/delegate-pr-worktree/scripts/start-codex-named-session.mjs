#!/usr/bin/env node

import { execFileSync } from "node:child_process";
import { homedir } from "node:os";
import { join, resolve } from "node:path";
import WebSocket from "ws";

const [worktreePath, sessionName, initialPrompt] = process.argv.slice(2);

if (!worktreePath || !sessionName || !initialPrompt || process.argv.length !== 5) {
  console.error(
    "Usage: start-codex-named-session.mjs <worktree-path> <session-name> <initial-prompt>",
  );
  process.exit(1);
}

const gitCommonDir = execFileSync(
  "git",
  ["-C", worktreePath, "rev-parse", "--path-format=absolute", "--git-common-dir"],
  { encoding: "utf8" },
).trim();

const gitDir = execFileSync(
  "git", ["-C", worktreePath, "rev-parse", "--absolute-git-dir"],
  { encoding: "utf8" },
).trim();
// Request scoped access to this worktree's protected directories. Host rules
// may still require approval for deletion. Never add the sibling-checkout parent.
const writableRoots = [...new Set([
  resolve(worktreePath), gitCommonDir, gitDir,
  join(resolve(worktreePath), ".codex"),
  join(resolve(worktreePath), ".agents"),
])];
const sessionConfig = {
  sandbox_workspace_write: {
    network_access: true,
    writable_roots: writableRoots,
  },
};

const codexHome = process.env.CODEX_HOME || join(homedir(), ".codex");
const socketPath = join(codexHome, "app-server-control", "app-server-control.sock");
const socket = new WebSocket(`ws+unix://${socketPath}:/`);
let nextRequestId = 1;
const pending = new Map();

function fail(message) {
  console.error(message);
  socket.terminate();
  process.exit(1);
}

function send(message) {
  socket.send(JSON.stringify(message));
}

function request(method, params) {
  const id = nextRequestId++;
  return new Promise((resolve, reject) => {
    pending.set(id, { resolve, reject });
    send({ id, method, params });
  });
}

socket.on("message", (data) => {
  const line = data.toString();
  let message;
  try {
    message = JSON.parse(line);
  } catch {
    fail(`Codex app-server returned invalid JSON: ${line}`);
  }

  if (message.id === undefined) return;
  const callback = pending.get(message.id);
  if (!callback) return;
  pending.delete(message.id);

  if (message.error) {
    callback.reject(new Error(message.error.message ?? JSON.stringify(message.error)));
  } else {
    callback.resolve(message.result);
  }
});
socket.on("error", (error) => fail(`Codex daemon connection failed: ${error.message}`));

const timeout = setTimeout(() => {
  fail("Timed out while finding or starting the named Codex session. Check existing sessions before retrying the same name.");
}, 30_000);

try {
  await new Promise((connected) => socket.once("open", connected));
  await request("initialize", {
    clientInfo: {
      name: "delegate-pr-worktree",
      title: "Delegate PR Worktree",
      version: "1.0.0",
    },
    capabilities: {
      experimentalApi: false,
      requestAttestation: false,
    },
  });
  send({ method: "initialized", params: {} });

  const matches = new Map();
  for (const archived of [false, true]) {
    let cursor;
    do {
      const page = await request("thread/list", {
        archived, cursor, limit: 100,
        sourceKinds: ["cli", "vscode", "exec", "appServer", "unknown"],
      });
      for (const thread of page.data) {
        if (!thread.parentThreadId && thread.name === sessionName) {
          matches.set(thread.id, thread);
        }
      }
      cursor = page.nextCursor;
    } while (cursor);
  }
  if (matches.size > 1) {
    throw new Error(`Multiple sessions match: ${[...matches.keys()].join(", ")}. Select the intended session; no new session was created.`);
  }
  const existing = [...matches.values()][0];
  if (existing) {
    if (resolve(existing.cwd) !== resolve(worktreePath)) {
      throw new Error(`Session ${existing.id} uses ${existing.cwd}. Reuse its original worktree.`);
    }
    await request("thread/resume", {
      threadId: existing.id,
      cwd: worktreePath,
      sandbox: "workspace-write",
      approvalPolicy: "on-request",
      config: sessionConfig,
    });
    clearTimeout(timeout);
    console.error(`Reusing Codex session ${existing.id}; preserving history and the current turn.`);
    console.log(existing.id);
    socket.close();
    // The terminal resumes this conversation without replaying the handoff.
  } else {

  const started = await request("thread/start", {
    cwd: worktreePath,
    sandbox: "workspace-write",
    approvalPolicy: "on-request",
    config: sessionConfig,
  });
  const threadId = started.thread.id;
  console.error(`Created Codex session ${threadId}.`);
  await request("thread/name/set", { threadId, name: sessionName });
  await request("turn/start", {
    threadId,
    cwd: worktreePath,
    approvalPolicy: "on-request",
    sandboxPolicy: {
      type: "workspaceWrite",
      networkAccess: true,
      writableRoots,
    },
    input: [{ type: "text", text: initialPrompt }],
  });
  clearTimeout(timeout);
  socket.close();
  console.log(threadId);
  }
} catch (error) {
  clearTimeout(timeout);
  fail(`Could not find or start the named Codex session: ${error.message}`);
}
