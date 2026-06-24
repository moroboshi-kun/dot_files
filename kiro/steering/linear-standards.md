# Linear Standards

## Purpose

Define conventions for managing Linear issues throughout their lifecycle — from creation through closure. This supplements the `linear-issue-creation` skill which covers issue structure and formatting.

## Issue Closure

Before marking any issue as Done:

1. Add a comment with verification details:
   - What was deployed and when
   - How it was verified (build passes, tests pass, confirmed live, etc.)
   - Any relevant context (e.g., "resolved by JUS-180" if closed as a side effect of another ticket)
2. Then change status to Done

Never close a ticket without adding closure context first.

## Commit References

Use `Closes` for all ticket references in commit footers — both GitHub issues and Linear tickets:

```text
fix(api): handle timeout errors

Closes #123
```

```text
feat(auth): add SSO integration

Closes JUS-456
```

```text
chore: remove dead code and duplicate methods

Closes JUS-182, JUS-183
```

## Status Transitions

| From | To | When |
|------|----|------|
| Backlog | In Progress | Work has actively started |
| In Progress | Done | Code deployed and verified |
| Done | In Progress | Reopened due to regression or incomplete work |

Do not skip from Backlog directly to Done without passing through In Progress (unless the issue was resolved as a side effect of other work).

## Combining Issues

Multiple issues may be resolved in a single branch/commit when:

- They are closely related (e.g., same file, same concern)
- Each is small and low-risk
- They don't warrant separate review

Reference all resolved tickets in the commit footer. Use a combined branch name (e.g., `chore/JUS-178-182-183-code-cleanup`).

## Monitoring State

For issues that require a monitoring period before full closure (e.g., CSP report-only mode), set status to In Progress and note the monitoring state in a comment. Close only after the monitoring period confirms success.
