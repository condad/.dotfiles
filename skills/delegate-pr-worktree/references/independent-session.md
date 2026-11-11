# Independent session mode

Use by default when no agent type is specified, when the user selects
`--agent`, or when they request a top-level agent in a new Ghostty tab. Preserve existing active sessions when reusing a task. These helpers are not used when the user selects `--subagent`.

Resolve `scripts/` relative to the skill root (the directory containing
`SKILL.md`), not this reference file or the target repository. The launcher has its own `ws` dependency; run `npm install --ignore-scripts` in this skill
directory when it is missing. Target projects need not use Node.js or Next.js;
Node.js is required only for these launch helpers.

Write a self-contained initial handoff with `Task`, `Workspace`, `Ownership`,
`Project workflow` (when applicable), and `Merge` sections. Include the exact
session name, repository, task/Issue and Project URLs, worktree, and branch.
Give the peer ownership of implementation, validation, commit, PR, questions,
accounting when applicable, and merge-confirmed cleanup. Tell it to read the
target repository instructions and use the existing worktree.

On macOS with Ghostty, invoke the absolute helper path:

```sh
osascript <skill>/scripts/start-codex-session-ghostty.applescript <worktree> <session-name> <initial-prompt>
node <skill>/scripts/attach-codex-session.mjs --verify <returned-status-path>
```

The helper uses the persistent local Codex app-server daemon. It checks every
page for the exact session name and resumes without replaying the handoff.
Always open a new Ghostty tab, even for an existing task; preserve active turns.
Verify the daemon's session name, ID, and cwd, remote CLI survival, and retained
stderr. Process survival does not prove an interactive attachment handshake;
report that limitation and forward any attachment error for diagnosis. Do not
interrupt an active task to test its terminal. After two failed attempts, report
the exact blocker and manual commands. Inspect sessions after a timeout before
retrying; never launch concurrently for the same task.

If Ghostty is unavailable, provide:

```sh
node <skill>/scripts/start-codex-named-session.mjs <worktree> <session-name> <initial-prompt>
codex resume --remote unix:// --cd <worktree> --include-non-interactive <session-id>
```

The launcher requests scoped worktree and Git metadata writable roots, network
access, `workspace-write`, and `on-request` approval. Host or managed policy can
still restrict them. Do not grant the supervisor workspace or home directory as
an additional root or bypass a denied write. Verify normal staging and commits;
do not use temporary indexes to evade permissions.

