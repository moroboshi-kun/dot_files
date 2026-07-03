---
name: git
description: Git workflow conventions for branching, committing, pushing, pull requests, and safety. Use when performing any git operation.
---

## Commit Workflow

Follow this sequence for every commit:

1. Run `git status` to review staged and unstaged changes.
2. Stage specific files relevant to the commit — avoid `git add .` unless all changes belong together.
3. Craft the commit message following Conventional Commits (see `conventional-commit-standards.md`).
4. Commit.

Do not commit without reviewing what will be included.

## Branch Naming

Use descriptive branch names that reflect the work:

- `feat/add-auth-flow`
- `fix/null-response-handling`
- `chore/JUS-178-182-183-code-cleanup`

When a branch resolves multiple Linear issues, combine the identifiers in the branch name.

Do not push directly to main/master unless explicitly told to.

## Push Rules

- Use `-u` flag on first push to set upstream tracking.
- Prefer feature branches for any non-trivial work.
- Never force push without explicit user confirmation.

## Pull Request Conventions

When creating PRs:

- **Title** — concise, under 70 characters, summarizes the change
- **Description** — structured with:
  - Summary of changes
  - What was tested
  - Any notes or blockers
- **Base branch** — target the correct branch (typically main)
- **Issue links** — reference related issues when known

## Issue References in Commits

Use `Closes` in commit footers for both GitHub issues and Linear tickets:

```text
feat(auth): Add SSO integration

Closes JUS-456
```

```text
chore: Remove dead code and duplicate methods

Closes JUS-182, JUS-183
```

## Safety Rules

### Before committing
- Flag files likely to contain secrets (.env, credentials, keys, tokens)
- Verify no unintended files are staged

### Destructive operations
These require explicit user confirmation before executing:
- `git push --force` / `git push -f`
- `git reset --hard`
- `git clean -f`
- `git branch -D`
- `git rebase` on shared branches

Explain what the operation will do, what could be lost, and whether it is reversible.

### Amending
- Prefer new commits over `--amend`
- Only amend unpushed commits when the user explicitly asks

## What NOT to Do

- Do not commit with vague messages ("update code", "fix stuff", "changes")
- Do not stage everything without reviewing what is included
- Do not push to main/master without being told to
- Do not force push, hard reset, or delete branches without confirmation
- Do not commit secrets, even accidentally — if detected, warn immediately
