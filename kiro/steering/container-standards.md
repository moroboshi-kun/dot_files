# Container and Kubernetes Standards

## Dockerfiles

- Use multi-stage builds to minimize final image size
- Pin base image versions; use digest pinning when stability matters
- Run as non-root; create a dedicated user
- Use COPY over ADD unless extracting archives
- Order layers for cache efficiency: dependencies before source code
- Avoid installing unnecessary packages
- Use .dockerignore to exclude build context bloat
- Prefer distroless or minimal base images for production
- Set HEALTHCHECK when appropriate
- Do not store secrets in images or build args
- Lint with hadolint

## Docker Compose

- Use named volumes for persistent data
- Use networks to isolate services
- Pin image versions
- Use environment variable files over inline secrets
- Define health checks and dependency ordering
- Keep compose files focused on a specific purpose (local dev, integration testing, etc.)

## Kubernetes Manifests

### Resources and Probes
- Always set resource requests and limits
- Always define liveness and readiness probes
- Use appropriate probe types (HTTP, TCP, exec) based on the workload

### Organization
- Use namespaces for isolation
- Apply labels consistently: app, version, component, managed-by
- Prefer Deployments over bare Pods
- Use ConfigMaps for config, Secrets for sensitive data

### Security
- Set security contexts: non-root, read-only root filesystem, drop all capabilities, add only what is needed
- Set automountServiceAccountToken to false when not needed
- Use network policies to restrict pod-to-pod traffic
- Use pod security standards (restricted profile preferred)
- Never expose cluster admin or broad RBAC without justification

### Reliability
- Set pod disruption budgets for production workloads
- Use anti-affinity rules to spread replicas across nodes
- Define appropriate update strategy (rolling update with maxUnavailable/maxSurge)

## Helm

- Keep values.yaml well-documented with comments
- Use sensible defaults that work without customization
- Template only what needs to vary; avoid over-parameterization
- Validate with helm lint and helm template before shipping
- Pin dependency chart versions
- Use chart tests when they add value

## Kustomize

- Use base + overlay pattern for environment differences
- Prefer patches over duplicating entire manifests
- Keep bases generic and overlays environment-specific

## Image Security

- Scan images for vulnerabilities (trivy, grype)
- Do not use :latest in production
- Rotate base images when upstream CVEs are published
- Use read-only filesystems where possible
- Minimize installed packages and tools in production images

## Review Checklist

When reviewing container or Kubernetes configs, check for:
- Missing resource limits
- Missing probes
- Running as root
- Overly permissive RBAC
- Secrets in plain text or build args
- Missing network policies
- Unbounded replicas without HPA
- Missing pod disruption budgets
- Unpinned image tags
- Unnecessary privilege escalation
