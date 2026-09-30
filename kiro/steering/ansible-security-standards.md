# Ansible Security Standards

Security conventions for Ansible projects: playbooks, roles, inventory, variables, and templated output. Scoped to configuration-management concerns; not a general cloud-security doc.

## Rule Citation Protocol (pilot)

Each rule below has a stable ID in the form `ANSSEC-NN`. When one of these rules materially influences a recommendation, flag, or code change, cite its ID in brackets, e.g. `[ANSSEC-03]`.

- Cite the ID where the rule is applied, or collect citations in a short trailer line at the end of the response.
- Cite only when a rule genuinely shaped the output — do not invent citations or cite rules that did not apply.
- Keep citations terse: the bracketed ID is enough; do not restate the full rule text.
- If unsure whether a rule applied, do not cite it.

This is a pilot mechanism for validating and tracing steering rules. It is a helpful signal, not a guarantee: absence of a citation does not prove a rule was not considered.

## Secrets and Sensitive Data

- **ANSSEC-01** — Never commit plaintext secrets to playbooks, `group_vars`, `host_vars`, `defaults`, or `vars` files. Use `ansible-vault` (encrypted files or encrypted variables) for all credentials, keys, and tokens.
- **ANSSEC-02** — Keep vault password files, key material, and decrypted secrets out of the repository. Ensure they are covered by `.gitignore` and never printed.
- **ANSSEC-03** — Set `no_log: true` on any task that handles secrets (passwords, tokens, private keys, connection strings) so values are not exposed in output, logs, or `--verbose` runs.
- **ANSSEC-04** — Do not expose secrets through `register`ed results, `debug` tasks, or command output. Mask or omit sensitive fields before display.
- **ANSSEC-05** — Prefer sourcing secrets from a managed store (e.g. a vault lookup or external secrets plugin) over embedding them, even encrypted, when the project supports it.

## Privilege Escalation

- **ANSSEC-06** — Use `become` only where required. Do not set `become: true` globally at the play level when a subset of tasks needs it; scope escalation to the tasks that need it.
- **ANSSEC-07** — Be explicit about `become_user`; do not assume root when a lower-privileged user suffices.
- **ANSSEC-08** — Never hardcode `become` passwords in files; supply them via vault or prompted `--ask-become-pass`.

## Command and Template Injection

- **ANSSEC-09** — Prefer purpose-built modules over `shell`/`command`. Reserve `shell`/`command` for cases with no module equivalent.
- **ANSSEC-10** — Never interpolate unvalidated user- or inventory-supplied variables directly into `shell`/`command` strings. Use `command` with argument lists, `quote` filters, or validated inputs to prevent injection.
- **ANSSEC-11** — Treat template (`.j2`) inputs as untrusted; avoid rendering unsanitized external data into files that are later executed or sourced.

## File Permissions and Ownership

- **ANSSEC-12** — Always set explicit `mode`, `owner`, and `group` on `copy`, `template`, and `file` tasks that create sensitive files. Do not rely on default umask.
- **ANSSEC-13** — Restrict permissions on files containing secrets or credentials to the minimum required (e.g. `0600` or `0640`), owned by the intended service account.

## Connection and Transport

- **ANSSEC-14** — Prefer key-based SSH authentication over passwords. Do not disable host key checking (`host_key_checking = false`) except in explicitly isolated, non-production contexts, and flag it as a risk when present.
- **ANSSEC-15** — Avoid storing connection credentials in inventory in plaintext; use vault or a credentials mechanism.

## Idempotence and Safety

- **ANSSEC-16** — Prefer idempotent modules; flag `shell`/`command` tasks that lack `creates`/`removes`/`changed_when` guards, as non-idempotent tasks can mask or repeat security-relevant changes.
- **ANSSEC-17** — When reviewing, flag tasks that weaken security posture (disabling SELinux/firewalld, opening broad firewall rules, world-writable modes, `validate_certs: false`) unless explicitly justified.

## Review Behavior

When reviewing an Ansible project for security, identify: plaintext secrets, missing `no_log`, over-broad `become`, injection-prone `shell`/`command` usage, missing or permissive file modes, disabled TLS/host-key/cert validation, and non-idempotent privileged tasks. Prioritize hard secret-exposure findings first.
