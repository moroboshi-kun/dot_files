# Conventional Commit Standards

## Purpose

All Git commit messages must follow the Conventional Commits specification as specified here: https://www.conventionalcommits.org/en/v1.0.0/. This standard improves repository history readability, enables automated changelog generation, supports semantic versioning workflows, and provides consistent communication across development teams.

## Requirements

Every commit message must use the following format:

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Examples:

```text
feat(auth): add JWT refresh token support
fix(api): handle null response from user service
docs(readme): update installation instructions
refactor(database): simplify connection pooling logic
```

### Commit Structure

#### Type

The commit type must be one of the following:

| Type | Purpose |
|------|---------|
| feat | Introduces a new feature |
| fix | Corrects a bug |
| docs | Documentation-only changes |
| style | Formatting, whitespace, or non-functional code style changes |
| refactor | Code changes that neither fix a bug nor add a feature |
| perf | Performance improvements |
| test | Adds or updates tests |
| build | Changes affecting build systems or dependencies |
| ci | CI/CD pipeline changes |
| chore | Maintenance tasks and miscellaneous updates |
| revert | Reverts a previous commit |

#### Scope

A scope should be included whenever the affected component, service, module, or subsystem is known.

Examples:

```text
feat(auth): add OAuth login support
fix(terraform): correct security group rules
docs(api): update endpoint documentation
refactor(frontend): simplify state management
```

#### Description

The description must:

* Be concise and specific.
* Use the imperative mood.
* Begin with an uppercase letter. This project prefers commit descriptions begin with an uppercase letter unless specified otherwise.
* Not end with punctuation.

Good examples:

```text
feat(users): Add password reset workflow
fix(api): Prevent duplicate record creation
refactor(cache): Reduce memory usage
```

Bad examples:

```text
feat(users): Added password reset workflow.
fix: Fixed bug.
refactor(cache): Changes to cache.
```

## Breaking Changes

Breaking changes must be indicated by either:

1. Appending `!` after the type or scope.
2. Including a `BREAKING CHANGE:` footer in the commit message.

Examples:

```text
feat(api)!: remove legacy authentication endpoint
```

```text
feat(auth)!: replace session tokens with JWT
```

```text
feat(auth): replace session tokens with JWT

BREAKING CHANGE: session-based authentication has been removed in favor of JWT authentication.
```

When a breaking change is introduced, additional details should be included in the commit body and/or `BREAKING CHANGE:` footer to help developers understand the impact and required migration steps.

## Commit Body

A body should be added when additional context is needed.

Example:

```text
fix(database): prevent connection leaks

Connections were not being released when exceptions occurred
during transaction processing.
```

## Commit Footer

Use footers for issue references and metadata.

Examples:

```text
fix(api): handle timeout errors

Closes #123
```

```text
feat(auth): add SSO integration

Refs: SEC-456
```

## Agent Instructions

When generating commit messages:

1. Always use Conventional Commit syntax.
2. Select the most accurate commit type.
3. Include a scope when the affected component is known.
4. Keep descriptions concise and action-oriented.
5. Use imperative mood.
6. Mark breaking changes with `!` or a `BREAKING CHANGE:` footer.
7. Generate commit bodies only when additional context adds value.
8. Never create vague commit messages such as:

   * `update code`
   * `fix stuff`
   * `changes`
   * `misc updates`

## Examples

```text
feat(auth): add multi-factor authentication

fix(terraform): correct route table association

docs(readme): document local development workflow

refactor(api): extract request validation middleware

test(users): add password reset integration tests

ci(github): add automated dependency scanning

chore(deps): update express to latest version
```

## Compliance

All generated Git commit messages must comply with this standard unless a repository-specific policy explicitly overrides it.
