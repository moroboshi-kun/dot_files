# Architecture Principles

## Core decision model
All recommendations should balance:
- business fit
- simplicity
- security
- reliability
- operability
- cost

Do not optimize one dimension in isolation.

## Simplicity first
- Recommend the simplest architecture that satisfies the requirements
- Avoid introducing extra control planes or orchestration layers without clear need
- Do not recommend EKS, service meshes, or event-heavy decomposition by default

## Incremental evolution
- Favor architectures that can be adopted in stages
- Prefer migrations with coexistence periods over forced cutovers
- Explicitly describe rollback or fallback paths for major changes

## Clear tradeoffs
- State why the recommended option is preferred
- State when an alternative would become the better choice
- Distinguish between current needs and speculative future needs

## Operational realism
- Consider the likely skills and bandwidth of the team
- Prefer designs that can be debugged, monitored, and supported by the current organization
- Recommend managed operations where the team would otherwise inherit heavy burden

## Practical outputs
Architecture advice should produce something implementable:
- clear service choices
- major network boundaries
- data flow
- security considerations
- rollout sequence
- validation ideas

## Common recommendation patterns
- Choose Lambda when the workload is event-driven, bursty, or operationally simple
- Choose ECS/Fargate for long-running container workloads or straightforward service platforms
- Choose RDS/Aurora when relational needs, transactional consistency, or familiar SQL operations dominate
- Choose DynamoDB when access patterns are well understood and scale/latency characteristics justify it
- Put CloudFront in front of public web delivery when origin protection, caching, or edge distribution matter
- Prefer SQS/EventBridge for decoupling over tightly coupled synchronous chains where appropriate
