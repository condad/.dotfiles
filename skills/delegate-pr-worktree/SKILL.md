---
name: delegate-pr-worktree
description: "Delegate a repository task in an isolated Git worktree to a top-level agent in a new Ghostty tab by default, or a subagent when selected, then open a reviewable PR."
---

# Delegate PR Worktree

Recognize `$delegate-pr-worktree`, `$delegate-worktree`, and `delegate-worktree`.
Accept a repository path or URL and a task description, Issue, or Project item.
Infer the repository from an Issue URL or unambiguous conversation context;
ask only when the target cannot be resolved uniquely. A GitHub Project is optional.

## Choose the agent type

The user can select either type when invoking this skill:

| Prompt option | Task owner | Terminal behavior |
| --- | --- | --- |
| `--subagent` | A subagent of the supervising conversation | No new Ghostty tab or Codex process |
| No option, or `--agent` | An independent top-level agent session | Open a new Ghostty tab attached to that session |

Examples:

- `delegate-worktree #45` — top-level agent in a new Ghostty tab by default.
- `delegate-worktree #45 --subagent` — explicitly select a subagent.
- `delegate-worktree #45 --agent` — select a top-level agent in a new Ghostty tab.
- `delegate-worktree condad/another-repo #12 --agent` — select another repository and a top-level agent.

These are instructions in the user's prompt, not a shell command or arguments
passed to the launcher scripts. Also accept equivalent plain language such as
“use a subagent” or “open a top-level agent in a new Ghostty tab.” If the user
specifies contradictory choices, clarify before launching. Both types use the
same isolated worktree, implementation scope, PR requirements, and Project
accounting workflow. Record the selected type in the handoff and delegation report.
For `--agent`, read [Independent session mode](references/independent-session.md)
and use the existing Ghostty launch/verification helpers. For `--subagent`, use
subagent tools and do not run those helpers or open a terminal tab.

## Resolve and reuse

The supervising conversation coordinates delegated tasks across repositories.
Default to an independent top-level agent in a new Ghostty tab; read
[Independent session mode](references/independent-session.md) for launch and
verification. Use a subagent only when selected with `--subagent` or equivalent
plain language. Keep existing task owners, including independent sessions,
unless the user requests a transfer. Do not restart an existing task merely
because the default mode changed.

Before setup, verify the target checkout's root, remote, default base branch,
`AGENTS.md`, and task acceptance criteria. Preserve existing changes. Inspect
an associated Project and its actual fields rather than assuming an owner,
number, or title. An Issue is the canonical work record when supplied; do not
replace it with a PR-only item or overwrite its description with progress notes.

Inspect this conversation's subagents, available active/archived task-session
lists, and the repository's branches and worktrees for a matching task. Reuse
its existing owner and worktree; ask which to use if multiple matches are
ambiguous. Report any unavailable discovery source instead of claiming it
was checked. Record the owning agent/thread ID so later instructions can be
routed to it without duplicating the task.

## Worktree isolation

- Create a task branch (`feat/` or `fix/`) and worktree directly under
  `/Users/condad/dev/<repository>-<task>`, for example
  `/Users/condad/dev/gosk-apply-issue-45`. Never implement in the parent checkout.
- Include repository and task identity in the agent name, branch, and worktree.
- Link existing untracked `.env`, `.env.local`, and `.env.*.local` files from
  the same project's parent checkout using relative symlinks only when the
  destination is absent. Exclude tracked examples; never expose or commit secrets
  or environment links.
- A subagent does not automatically get a new cwd, sandbox, or worktree. It
  inherits permissions. Pass its absolute worktree path and require every Git,
  implementation, build, lint, and test operation to target that worktree.
  Verify its repository root and branch before implementation. Request actual
  required permissions through the supported approval flow; do not bypass a
  denied write or use temporary Git indexes to evade restrictions.

## Delegate and coordinate

The supervisor may perform setup directly. In subagent mode, if setup is
delegated, use the same subagent to continue implementation rather than spawning
a second task owner. In agent mode, launch the top-level owner using the
independent-session reference. Give the selected task owner a self-contained
handoff with:

- Task: repository, Issue/task URL, acceptance criteria, and applicable Project URL.
- Workspace: parent checkout, absolute task worktree, branch, and base branch.
- Ownership: implementation, validation, commits, push, PR, progress, and blockers.
  Read the repository's instructions and build configuration before choosing checks.
- Project workflow: delegation-start timestamp and accounting requirements when applicable.
- Merge: no merge without separate user authorization; retain the worktree until
  merge is confirmed and the checkout is clean.

In subagent mode, use the available subagent tools to spawn, message, inspect,
and resume the owning subagent. Relay user corrections to it, collect progress and results,
and surface questions, permission restrictions, and blockers in the supervising
conversation. Do not launch Ghostty, start another Codex process, or install
launcher dependencies in subagent mode. If subagent tools are unavailable,
report that limitation rather than silently substituting an independent session.

Before reporting a successful delegation, obtain the agent's confirmation of
its worktree root, branch, and accepted scope. Report the task/Project links,
selected type, agent name and thread/session ID, worktree, branch, checks already
completed, and any PR link.
Distinguish setup verification from implementation checks. The supervisor
remains responsible for coordination through the reviewable PR handoff; the
selected task owner owns project edits and validation.

## Implementation, accounting, and completion

The task owner runs repository-required checks and focused validation, reviews
its diff, commits, pushes, and opens a PR against the resolved base branch.
Describe the resulting behavior, validation, and relevant configuration changes;
include `Resolves #<number>` when implementing an Issue. If the user requests
only setup, a branch, or a worktree, stop at that scope.

When a Project is associated, inspect its supported fields and follow
[Project accounting](references/project-accounting.md). Record the delegation
start and set `In Progress` before implementation when supported. Without a
Project, omit Project field updates and accounting requirements.

Opening a PR does not authorize merging. After explicit merge confirmation,
verify the Issue's completed close reason when applicable and finish accounting.
Resolve exact task worktree and branch names, check for uncommitted changes,
and remove a clean worktree with ordinary `git worktree remove` from a surviving
directory. Delete only the task's local and remote branches. Do not use `--force`
or remove unrelated changes. Preserve anything permissions or dirty state prevent
cleaning up, and report the limitation.
