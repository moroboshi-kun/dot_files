---
name: linear-issue-creation
description: Create Linear issues with consistent structure, actionable implementation detail, clear dependencies, and safety notes. Use when creating issues, tasks, or tickets in Linear.
---

## Issue Structure

Every issue must include the following sections in its description. Omit a section only if it genuinely does not apply.

### 1. Summary (first paragraph)

A concise statement of what needs to be done and why. One to three sentences. No heading needed — this is the opening text of the description.

### 2. Implementation Detail

Specific, actionable information an engineer needs to do the work:

- **Terraform resources** — resource types, key arguments, naming conventions
- **Code changes** — file paths, specific values to set, code snippets in fenced blocks
- **CLI commands** — exact commands if relevant
- **Configuration** — settings, parameters, environment variables

Use fenced code blocks for any code, config, or CLI examples. Specify the language for syntax highlighting.

### 3. Prerequisites

What must be true or complete before this issue can be started. Reference other issue IDs (e.g., JUS-155) when the dependency is another tracked issue.

### 4. Sequencing Notes

Where this issue fits in the broader plan:
- What must happen before this issue
- What is blocked by this issue
- Any ordering constraints within the issue itself

### 5. Acceptance Criteria

How to verify the work is done correctly. Concrete, testable statements:
- "ALB returns 200 on https://shared.dev.zooplus.fun"
- "Target group shows healthy status in AWS console"
- "HLS stream plays in browser without errors"

### 6. Rollback / Safety Notes

How to undo this change if something goes wrong. Include only when the change carries risk:
- Terraform: "terraform destroy -target=aws_lb.main"
- Config: "Revert config.js and redeploy"
- DNS: "Change alias record back to A record with instance IP"

Flag any destructive or hard-to-reverse aspects explicitly.

## Formatting Rules

- Use Markdown throughout
- Use bold for section labels within the description (e.g., **Terraform resources:**)
- Use bullet lists for enumerations, not numbered lists (unless order matters)
- Use fenced code blocks with language tags for all code/config/CLI
- Keep descriptions scannable — avoid long prose paragraphs
- Reference specific file paths relative to the repo root
- Include resource names, ARNs, IDs, or other concrete identifiers when known

## Title Rules

- Titles should be imperative and specific: "Create ALB security group", not "Security group work"
- Keep titles under 80 characters
- Don't include the project name or phase number in the title — that's what milestones are for

## What NOT to Include

- Background context or rationale that belongs in the architecture doc, not the issue
- Duplicate information already in the milestone description
- Vague statements like "investigate options" or "figure out the best approach" — issues should represent decided work, not research
- Assignee or priority unless explicitly requested

## Example: Good Issue

```markdown
Create a security group for the shared ALB.

**Ingress rules:**
- 443/tcp from 0.0.0.0/0 (HTTPS)
- 80/tcp from 0.0.0.0/0 (HTTP, redirects to HTTPS)

**Egress rules:**
- 3000/tcp to instance security group (sg-094161c17e51c07db)
- 8888/tcp to instance security group (sg-094161c17e51c07db)

**Terraform resource:**
```hcl
resource "aws_security_group" "alb" {
  name_prefix = "cupola360-alb-"
  vpc_id      = var.vpc_id
}
```

**Prerequisites:**
- VPC ID confirmed

**Acceptance criteria:**
- Security group exists with correct rules
- ALB can be created referencing this SG

**Rollback:**
- `terraform destroy -target=aws_security_group.alb`
```

## Example: Bad Issue

```markdown
We need a security group for the load balancer. It should allow HTTPS traffic in and let the ALB talk to the instances.
```

(Too vague — no specific ports, no resource references, no acceptance criteria, no rollback path.)
