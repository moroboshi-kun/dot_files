---
name: session-handoff
description: Save or resume working context for a repo in `.context.md`. Use when the user says "update context", "save context", or "hand off", is ending a session or moving to a new directory or tool, or asks to "pick up where we left off" or "read the context file".
---

# Session Handoff

`.context.md` at the repo root (or the current directory if not in a git repo) is a snapshot of where
work stands, so a later session — in Claude, Kiro, or another tool — can pick up without re-deriving it.

Decide the mode from the request:
- **Save**: "update context", "save context", "hand off", ending a session, moving directories/tools.
- **Resume**: "pick up where we left off", "read the context file", starting work in a repo that has `.context.md`.

## Save mode

1. Read the existing `.context.md` if present. Rewrite it in place as a current snapshot — not an
   append-only log. Carry forward anything still true; drop what is resolved or obsolete.
2. Gather facts from the conversation and the repo (`git status --short`, `git log --oneline -10`,
   current branch). Prefer what the repo shows over what the conversation assumed.
3. Write the file using the template below. Keep it under ~150 lines.
4. Check it is ignored: `git check-ignore -q .context.md`.
   - If not ignored, tell the user and suggest adding `.context.md` to the global ignore file
     `~/.config/git/ignore` (applies to every repo on the machine). Do not edit any ignore file
     without asking.
5. Reply with a short summary of what changed in the file (added / updated / removed items).

### Template

```markdown
# Context: <project or effort name>

_Last updated: <YYYY-MM-DD> · branch `<branch>` · HEAD `<short sha>`_

## Goal
<1–3 lines: what this project or effort is for>

## Current state
- [x] <done item> — tested
- [x] <done item> — **untested**
- [ ] <in-progress item> — <where it stands>

## Decisions
- <decision> — <why>, so it isn't re-litigated

## Open questions
- <parked question> — <any context needed to answer it>

## Next steps
1. <next action>
2. <after that>

## Environment notes
- <tool versions, paths, install methods, relevant config locations>

## Recent sessions
- <YYYY-MM-DD>: <one line on what happened>
```

Keep "Recent sessions" to the last ~5 entries; drop the oldest.

### Rules

- **Never write secrets** — no tokens, keys, passwords, credential values, or private hostnames
  with credentials. Reference where a secret lives (e.g. "PAT in env var `GITHUB_PERSONAL_ACCESS_TOKEN`"),
  never its value.
- Always distinguish **tested** from **untested** for completed work.
- Use absolute dates, never "today" or "yesterday".
- Record decisions with their reason; a decision without a reason gets re-argued.

## Resume mode

1. Read `.context.md`. If it does not exist, say so and offer to create one from the current state.
2. Verify it against the repo:
   - Do items marked done actually exist (files, roles, commits)?
   - Commits since the snapshot: `git log --oneline <HEAD sha from header>..HEAD`.
   - Uncommitted changes: `git status --short`.
3. Report back concisely:
   - Where things stand, in a few lines.
   - Anything stale or contradicted by the repo.
   - Open questions and the next step from the file.
   - Whether there is enough information to continue; if not, list the specific gaps.
4. Make no changes until the user confirms how to proceed.
