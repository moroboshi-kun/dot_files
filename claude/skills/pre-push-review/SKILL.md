---
name: pre-push-review
description: Review unpushed commits before a git push. Use when the user asks to check commits before pushing, asks "is this good to push?", "are the commits good to push?", or similar. Read-only; reports findings and does not change anything.
---

# Pre-Push Review

Review everything that a `git push` would send, report a verdict, and change nothing. Never amend,
rebase, reset, stage, commit, or push as part of this review — suggest those as follow-ups instead.

Commit-message and branch conventions come from the `git` skill
([conventional-commit-standards.md](../git/conventional-commit-standards.md)).

## 1. Determine the range

```bash
git fetch
git rev-parse --abbrev-ref --symbolic-full-name @{u}
```

- With an upstream: base = `@{u}`, range = `@{u}..HEAD`.
- Without one: base = the remote default branch (`git rev-parse --abbrev-ref origin/HEAD`, else
  `origin/main` / `origin/master`); note that the branch has no upstream yet and the user's
  first push needs `git push -u`.
- If the range is empty, say there is nothing to push and stop.

## 2. Branch state

- Ahead/behind counts: `git rev-list --left-right --count @{u}...HEAD`. Behind > 0 means the push
  will be rejected or needs a pull/rebase first.
- Flag pushing directly to `main`/`master` (only fine if the user said so).
- Check the branch name against the `git` skill's naming convention.

## 3. Commits

For each commit in `git log --format='%h %s%n%b' <range>`:

- Conventional Commit format: `<type>[optional scope]: <description>`, imperative mood, no vague messages.
- The message matches what the diff actually does (`git show --stat <sha>`, and the diff when needed).
- One concern per commit — flag commits that mix unrelated changes.
- Issue references: if the work clearly relates to a Linear or GitHub issue, check for a `Closes` footer.

## 4. Diff review

Review `git diff <base>...HEAD` for:

- **Secrets**: tokens, keys, passwords, private keys, connection strings, `.env` contents.
  (`github_pat_`, `AKIA`, `-----BEGIN`, `password=`, etc.) — highest severity.
- **Debug leftovers**: print/console.log debugging, commented-out blocks, TODO/FIXME added in this push.
- **Large or binary files**: anything big or generated that likely shouldn't be versioned.
- **Files that should be ignored**: `.context.md`, `.env*`, `*.tfstate*`, `*.tfplan`, `.terraform/`,
  `node_modules/`, build output, editor files.

## 5. Working tree

`git status --short` — flag uncommitted or untracked files that look like they belong with this push
(e.g. a new file referenced by a committed change but not itself committed).

## 6. Mechanical checks

- If the repo has `.pre-commit-config.yaml`: run
  `pre-commit run --from-ref <base> --to-ref HEAD`. This will prompt for permission; hooks such as
  formatters may modify files. Report hook results and list any files a hook modified.
- If there is no config, note it in one line and move on. Do not suggest adding one unless the repo
  type has an obvious fit (e.g. Terraform → `pre-commit-terraform`).

## 7. Verdict

Start the report with one line:

- ✅ **Ready to push**
- ⚠️ **Ready with notes** — nothing blocking, but worth a look
- ❌ **Not ready** — secrets, behind remote, failing checks, or commits that don't match their diffs

Then list findings most severe first, each with the commit sha or file and a suggested fix.
Keep it short when everything passes.
