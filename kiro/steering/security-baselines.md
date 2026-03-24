# Security Baselines

## General security posture
- Treat internet exposure as a meaningful design decision, not a default
- Minimize attack surface
- Prefer service-to-service communication over private paths where possible
- Prefer managed identity and managed secret distribution

## Hard requirements
- Do not recommend plaintext secrets in code, repos, environment files, or Terraform tfvars files
- Flag public S3 access as high risk unless explicitly intended and protected
- Flag 0.0.0.0/0 ingress as high risk unless clearly required and narrowly scoped
- Flag broad IAM permissions as high risk
- Recommend audit logging for production-impacting systems

## Secret management
Preferred options:
1. AWS Secrets Manager
2. SSM Parameter Store for simpler secret/config use cases

Recommendations should mention secret rotation and access scoping when material.

## Logging and audit
- CloudTrail should be considered part of the baseline for AWS account auditability
- Production systems should log enough to support incident investigation
- Architecture recommendations should note any significant monitoring or audit blind spots

## Data handling
- Call out where sensitive data is stored, processed, or transmitted
- Recommend encryption boundaries clearly
- Mention backup and recovery needs for critical data stores

## Review behavior
When reviewing an architecture, identify:
- exposure points
- trust boundaries
- secret distribution path
- permission model
- likely misconfiguration risks
