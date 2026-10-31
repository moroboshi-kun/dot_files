---
name: git
description: Git workflow conventions for branching, committing, pushing, pull requests, and safety. Use when performing any git operation.
---

## Commit Workflow

Follow this sequence for every commit:

1. Run `git status` to review staged and unstaged changes.
2. Stage specific files relevant to the commit — avoid `git add .` unless all changes belong together.
3. Craft the commit message following Conventional Commits (see [conventional-commit-standards.md](conventional-commit-standards.md)).
4. Commit.

Do not commit without reviewing what will be included.

## Branch Naming

Use descriptive branch names that reflect the work:

- `feat/add-auth-flow`
- `fix/null-response-handling`
- `chore/JUS-178-182-183-code-cleanup`

When a branch resolves multiple Linear issues, combine the identifiers in the branch name.

Do not push at all — the user runs pushes (see Push Rules). Never commit directly toward
main/master as if it will be pushed for you.

## Push Rules

**Agents do not push. The user runs all `git push` operations themselves.**

- Do not run `git push` (plain or force) — it is denied by agent policy. Prepare the
  work up to the commit, then stop and tell the user the branch is ready to push.
- When a first push will be needed, note that the user should use `git push -u` to set
  upstream tracking (do not run it yourself).
- Prefer feature branches for any non-trivial work.

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

Reference issues in commit footers using `Closes` for both GitHub issues and Linear tickets. See [conventional-commit-standards.md](conventional-commit-standards.md) for footer format and [linear-standards.md](../linear-issue-creation/linear-standards.md) for ticket-reference conventions.

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

- Do not commit with vague messages (see [conventional-commit-standards.md](conventional-commit-standards.md) for message rules)
- Do not stage everything without reviewing what is included
- Do not run `git push` — pushes are the user's job (agent push is denied by policy)
- Do not force push, hard reset, or delete branches without confirmation
- Do not commit secrets, even accidentally — if detected, warn immediately
