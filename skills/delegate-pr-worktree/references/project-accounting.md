# GitHub Project Accounting

Apply these steps only when a GitHub Project is associated with the task and its fields support this workflow. Inspect its actual schema first; do not create missing fields without authorization.

- Immediately after creating the PR, and after every later PR mutation
  (including a push, title or body edit, or accounting-comment edit), read the
  launched task's own local transcript in `$CODEX_HOME/sessions` (normally
  `~/.codex/sessions`). Identify it by the owning task agent/thread ID and transcript
  metadata, then read `turn_context.payload.model` and the latest
  `token_usage_record.payload.thread_token_usage`. The Project token fields
  represent the assigned task: use the owning implementation thread's actual
  cumulative usage, whether it is a subagent or an independent session. Do not
  attribute the supervising conversation's cumulative usage to a single task.
  Include additional task-specific contributor threads only when their usage
  is recorded separately and is not already included in another reported total;
  never count an individual turn as a whole-thread total or double-count usage.
- Upsert one clearly marked PR accounting comment that preserves every
  checkpoint. Each checkpoint contains the pushed SHA, task agent/thread ID,
  delegation-start timestamp, active model, and input, cached-input, output,
  reasoning, cache-write, and total-token values. Those values are the task's
  cumulative total at that checkpoint. For every distinct delegated task
  thread, use only its latest cumulative totals; sum those values into the
  Project item's `Input tokens`, `Cached input tokens`, and `Output tokens`
  fields on every PR creation or mutation. This prevents a later PR update or
  resume from double-counting earlier work. Update `Model` to the latest active
  model. If more than one model or task thread is used, the PR accounting
  comment remains the per-model source of truth.
- Never estimate or invent usage. If the task cannot find a matching local
  transcript or token record, record the commit and the exact limitation in
  the PR comment, leave the Project token fields unchanged, and report it.
  Do not declare accounting unavailable merely because the task cannot
  introspect itself; locate its own transcript before reporting the handoff.
- Do not rely on a live Codex session to notice a future merge. The durable PR
  checkpoints make the accounting available even if the session ends. A
  merge-triggered GitHub automation may later verify the `completed` close
  reason and set the Project item to `Done`; until that automation exists, do
  that status and cleanup work only when the merge is explicitly confirmed.
- Do not merge the PR unless the user separately authorizes it. When a merge is
  confirmed, verify that its linked Issue closed with the `completed` reason,
  set `Resolved at` to the merge date and `Resolution time (minutes)` to the
  elapsed whole minutes from the earliest delegation-start timestamp to the
  merge timestamp. Add both precise timestamps and the duration to the PR
  ledger, set the Project item to `Done`, then remove the delegated worktree
  and delete the local and remote branches if they still exist. Resolve the
  exact worktree and branch names before deleting them.
