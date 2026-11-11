#!/usr/bin/env node

import { execFileSync, spawn } from "node:child_process";
import { appendFileSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const args = process.argv.slice(2);
const delay = (ms) => new Promise((done) => setTimeout(done, ms));

if (args[0] === "--verify" && args.length === 2) {
  const deadline = Date.now() + 45_000;
  while (Date.now() < deadline) {
    let status;
    try { status = JSON.parse(readFileSync(args[1], "utf8")); } catch {}
    if (status?.state === "failed" || status?.state === "exited") {
      console.error(JSON.stringify(status));
      process.exit(1);
    }
    if (status?.state === "running") {
      try { process.kill(status.pid, 0); } catch (error) {
        console.error(error.code === "EPERM"
          ? "Sandbox denied process verification; rerun this check with approval."
          : "Remote CLI exited; inspect the launch status and error log.");
        process.exit(1);
      }
      console.log(JSON.stringify(status));
      process.exit(0);
    }
    await delay(500);
  }
  console.error("Launch verification timed out. Inspect the status, error log, and existing session before retrying.");
  process.exit(1);
}

if (args.length !== 4) {
  console.error("Usage: attach-codex-session.mjs <worktree> <name> <prompt> <status-path> | --verify <status-path>");
  process.exit(1);
}
const [worktree, name, prompt, statusPath] = args;
const errorLog = `${statusPath}.stderr`;
writeFileSync(errorLog, "", { mode: 0o600 });
let sessionId;
const record = (state, extra = {}) => writeFileSync(statusPath, JSON.stringify({
  state, sessionName: name, sessionId, worktree, errorLog, ...extra,
}), { mode: 0o600 });
record("starting");

try {
  sessionId = execFileSync("node", [
    join(dirname(fileURLToPath(import.meta.url)), "start-codex-named-session.mjs"),
    worktree, name, prompt,
  ], { encoding: "utf8", stdio: ["inherit", "pipe", "inherit"] }).trim();
} catch (error) {
  record("failed", { error: error.message });
  process.exit(1);
}

// Keep stdin/stdout attached to Ghostty's TTY. Retain startup errors without
// hiding them from the user. Process survival is evidence, not a protocol ack.
const child = spawn("codex", ["resume", "--remote", "unix://", "--cd", worktree,
  "--include-non-interactive", sessionId], { stdio: ["inherit", "inherit", "pipe"] });
record("attaching", { pid: child.pid });
child.stderr.on("data", (data) => {
  appendFileSync(errorLog, data);
  process.stderr.write(data);
});
const ready = setTimeout(() => record("running", { pid: child.pid }), 10_000);
child.on("error", (error) => {
  clearTimeout(ready);
  record("failed", { error: error.message });
  process.exitCode = 1;
});
child.on("exit", (code, signal) => {
  clearTimeout(ready);
  record("exited", { code, signal });
  process.exitCode = code ?? 1;
});
