# Shell Safety Standards

Conventions for how agents run destructive shell commands. Scoped to local
filesystem safety; complements the hard allow/deny command policy in each
agent's `toolsSettings.shell`.

## Deleting files: use trash, never rm

- **Never use `rm`, `rmdir`, `shred`, `unlink`, `find … -delete`, or
  `find … -exec rm`.** These are permanent and are denied by the agent shell
  policy; attempting them will be blocked, not merely discouraged.
- **To delete, use `trash-put <path>`** (from `trash-cli`). It moves files to
  the XDG trash (`~/.local/share/Trash`) instead of destroying them, so a
  mistaken delete is recoverable.
- **To review or recover**, use `trash-list` and `trash-restore`.
- **Do not run `trash-empty`.** Emptying the trash is a permanent delete and is
  left to the human to run deliberately — agents should never purge it.

Rationale: deletes are the least reversible routine shell action. Routing them
through the trash turns an irreversible mistake into a recoverable one, while
`trash-empty` staying manual preserves a human checkpoint before anything is
truly gone.

## General shell hygiene

- Prefer purpose-built tooling over ad hoc shell where an equivalent exists
  (e.g. a project's own task runner, linter, or test command).
- Do not pipe network downloads straight into a shell
  (`curl … | sh`, `wget … | bash`); download, inspect, then run.
- Quote and validate any path or value interpolated into a command to avoid
  word-splitting and injection.
- Prefer non-destructive git operations; treat history-rewriting or
  force-pushing commands as requiring explicit human direction.
- When a destructive action has no reversible alternative, stop and ask the
  human rather than proceeding.
