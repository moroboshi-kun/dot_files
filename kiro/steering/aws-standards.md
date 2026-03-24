# AWS Standards

## General platform defaults
- Prefer managed services where they provide a clear operational benefit
- Prefer AWS-native integrations over third-party dependencies unless there is a strong reason
- Prefer multi-AZ designs for production stateful systems where supported and justified
- Keep architectures understandable by the delivery team

## Tagging
All AWS resources should, where supported, include standard tags:
- Owner
- Application
- Environment
- ManagedBy
- CostCenter

Architecture recommendations should mention tagging when it affects governance or cost visibility.

## Networking
- Private-by-default is the baseline
- Public exposure must be deliberate and justified
- Separate edge, application, and data concerns clearly
- Use security groups and network boundaries to reduce blast radius
- Prefer VPC endpoints where they simplify or secure service-to-service access

## Ingress patterns
- Prefer CloudFront in front of public web applications when caching, TLS termination strategy, geographic distribution, or origin protection matters
- Prefer ALB for HTTP/HTTPS service ingress
- Prefer NLB only when transport-layer behavior or very specific performance characteristics are needed
- Avoid exposing workloads directly when a managed ingress layer is more appropriate

## IAM
- Least privilege is the default
- Avoid wildcard actions and wildcard resources unless there is a documented reason
- Prefer role-based access and short-lived credentials
- Separate runtime permissions from deployment permissions

## Data protection
- Encryption at rest is required for supported services
- Encryption in transit is required where supported
- Secrets must not be stored in source code, plaintext configuration, or Terraform variables files
- Prefer KMS-backed services and managed secret stores

## Observability
- Production systems should emit logs, metrics, and alarms
- Critical paths should have clear health indicators
- Distributed systems should consider tracing
- Architecture recommendations should explicitly mention observability for production-impacting components

## Resilience
- Avoid single points of failure unless clearly accepted
- State assumptions about RTO/RPO where relevant
- Prefer designs that degrade gracefully instead of failing catastrophically
