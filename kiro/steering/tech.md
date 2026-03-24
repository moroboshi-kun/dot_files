# Technology and Delivery Context

## Infrastructure as Code
- Terraform is the default source of truth for infrastructure changes
- Manual console changes should be treated as exceptions and called out as drift risks

## Typical AWS building blocks
Use or consider the following AWS services where appropriate:
- Networking: VPC, subnets, route tables, NAT, Internet Gateway, VPC endpoints
- Edge and ingress: CloudFront, Route53, ACM, WAF, ALB, NLB, API Gateway
- Compute: Lambda, ECS on Fargate, ECS on EC2, EC2
- Data: RDS, Aurora, DynamoDB, S3, ElastiCache, EFS
- Messaging and async: SQS, SNS, EventBridge, Step Functions
- Identity and secrets: IAM, KMS, Secrets Manager, SSM Parameter Store
- Observability: CloudWatch, X-Ray, CloudTrail, AWS Config
- Delivery and artifacts: ECR, CodeBuild, GitHub Actions, CI/CD integrations

## Architecture preference order
When recommending execution platforms, prefer roughly in this order unless constraints say otherwise:
1. Lambda for event-driven, bursty, or lightweight APIs and jobs
2. ECS/Fargate for containerized services without Kubernetes-specific requirements
3. ECS/EC2 for cases needing host-level control or cost/performance tuning
4. EKS only when Kubernetes capabilities are truly required

## Environment model
Assume multiple environments such as:
- dev
- stage
- prod

Recommendations should preserve environment parity when practical.

## Delivery expectations
- Recommend phased rollouts for significant changes
- Call out migration sequencing when introducing new components
- Prefer reversible changes over high-blast-radius cutovers
