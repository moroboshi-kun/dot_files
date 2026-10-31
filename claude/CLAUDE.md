# Global Standards

## Shell safety

- **Never delete with `rm`, `rmdir`, `shred`, `unlink`, `find … -delete`, or `find … -exec rm`.** A PreToolUse hook (`~/.claude/hooks/guard-bash.py`) blocks them.
- **To delete, use `trash-put <path>`.** It moves files to the XDG trash so a mistaken delete is recoverable. Review and recover with `trash-list` and `trash-restore`.
- **Never run `trash-empty`.** Emptying the trash is a permanent delete and is left to the human.
- Do not pipe network downloads into a shell (`curl … | sh`); download, inspect, then run.
- Prefer a project's own task runner, linter, or test command over ad hoc shell.
- Quote and validate any path or value interpolated into a command.
- Treat history rewriting as requiring explicit human direction.
- When a destructive action has no reversible alternative, stop and ask rather than proceeding.

## Git

- All commit messages follow Conventional Commits: `<type>[optional scope]: <description>`. Use the `git` skill for the full workflow, branch naming, PR conventions, and the commit standard.
- Reference issues in commit footers with `Closes` (GitHub `#123` and Linear `JUS-456` alike).
- **Never run `git push`** (plain or force) — the user runs all pushes, and it is denied in settings. Stop after committing and tell the user the branch is ready to push (noting when they'll need `git push -u`).

## Linear

- When creating, updating, or closing Linear issues, use the `linear-issue-creation` skill.
- Never mark an issue Done without first adding a closure comment with verification details.
