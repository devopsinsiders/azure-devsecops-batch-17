# Monolithic UI Deployment — Notes

## Purpose
This document captures a comprehensive summary and operational notes for the Monolithic UI deployment diagram in `diagram.pdf` (ClassNotes/102.MonolithicUIDeployment-16-11-2025). It describes the architecture, components, networking, security considerations, deployment runbook, observability, backup/restore, scaling and troubleshooting guidance.

## High-level Overview
- **Architecture style**: Monolithic UI — single deployable unit that serves user interface and application logic (often combined web + app layers) connecting to a backend database.
- **Primary goals**: Simple deployment, single artifact lifecycle, predictable behavior, minimal inter-service network complexity.

## Main Components (as shown in diagram)
- **Public Load Balancer / Reverse Proxy**: Routes incoming HTTP(S) traffic to front-end web servers. Terminates TLS or forwards to downstream TLS termination.
- **Web / App Servers**: Hosts the monolithic UI application (IIS, Apache, Nginx + app runtime). Handles routing, rendering, and business logic.
- **Database**: Central persistent store (e.g., SQL Server, MySQL, Postgres). Placed in private network with restricted access.
- **Cache Layer**: In-memory cache (Redis, Memcached) to reduce DB load for frequently-read data and session state offload (if used).
- **CDN**: Content Delivery Network for static assets (CSS, JS, images) to reduce origin load and improve latency.
- **Storage**: Object storage for user uploads or large static blobs (Azure Blob Storage, S3-like storage).
- **Management / Bastion Host**: Jumpbox or bastion used to access private resources for admin tasks.
- **Monitoring & Logging**: Centralized logging (ELK/EFK, Azure Monitor) and metrics (Prometheus, Application Insights) and alerting engines.

## Networking & Topology
- **VNet / Virtual Network**: Application components segmented into subnets (public, application, database). Use NSGs to restrict traffic flows.
- **Public Subnet**: Load balancer / reverse proxy components are reachable from the internet.
- **Private Subnet**: Web/app and backend services reside here. Only LB/front-door should allow inbound from internet.
- **Database Subnet**: Strictly private with no public access; only app servers allowed on specific ports.
- **Peering / VPN**: If on-premises integration exists, use VPN/ExpressRoute or peering with secure encryption.

## Security Considerations
- **TLS/SSL**: Enforce TLS 1.2+ for all external and internal traffic where feasible. Terminate TLS at the LB or use end-to-end TLS depending on compliance.
- **Certificates**: Manage certs with Key Vault / Certificate Manager and automate renewals.
- **Network Security Groups (NSGs)**: Least-privilege rules. Only allow required source/destination and ports.
- **Firewall / WAF**: Protect against OWASP Top 10 by placing a WAF in front of the application.
- **Identity & Access**: Use managed identities or service principals. Avoid storing secrets in code. Use Key Vault/Managed Secrets store.
- **OS & App Patching**: Keep web/app and DB patched and on supported versions.
- **Data Protection**: Encrypt data at-rest (DB & storage) and in-transit.

## CI/CD & Deployment
- **Build artifacts**: Produce a single versioned artifact (zip, container image, or deployable package).
- **Pipeline stages**: Build → Unit Tests → Integration Tests → Acceptance → Staging → Production.
- **Blue/Green or Canary**: Recommended to reduce downtime and enable quick rollback for monoliths.
- **Infrastructure as Code**: Use Terraform / ARM / Bicep to version and automate infra changes.
- **Configuration management**: Externalize environment configuration (secrets, connection strings) and avoid hardcoding.

## Deployment Runbook (example)
1. **Pre-deploy checks**
   - Verify infra health (LB, subnets, DB replicas).
   - Ensure certificates not expiring and backups are recent.
   - Review change window and notify stakeholders.
2. **Deploy to Staging**
   - Run full smoke tests and acceptance checks.
3. **Promote to Production (Blue/Green)**
   - Prepare green environment with new artifact.
   - Run canary tests (small percentage traffic) and validate metrics.
   - Switch LB to new environment if healthy.
4. **Post-deploy validation**
   - Run synthetic transactions, check application logs, metrics, error rates and latency.
5. **Rollback**
   - If severe issues: revert LB routing to previous revision and run health checks. Document cause and start root-cause analysis.

## Observability & Monitoring
- **Logs**: Centralize application logs and web server logs. Use structured logging for easy parsing.
- **Metrics**: Track request rates, error rates, response latency, DB connection counts, CPU/memory.
- **Tracing**: Distributed tracing (if any cross-process calls exist) to find slow paths.
- **Alerts**: Configure thresholds for high error rate, high latency, high DB CPU, low free disk, backup failures.

## Backup & Recovery
- **Database backups**: Schedule regular automated backups; perform retention and test restores periodically.
- **Storage snapshots**: For file stores, use snapshots or versioning and retain per policy.
- **Disaster recovery**: Define RTO/RPO and implement geo-replication if required.

## Scaling & High Availability
- **Scale vertically**: Increase VM size for short bursts.
- **Scale horizontally**: Add more web/app instances behind LB; ensure statelessness or externalize sessions.
- **Database HA**: Use replicas/read replicas for read scalability; use clustering or managed DB with automatic failover for HA.

## Session Management
- **In-memory sessions**: Not safe for horizontal scaling unless sticky sessions used.
- **Recommended**: Use distributed session store (Redis) or store session tokens in client (JWT) where appropriate.

## Common Ports & Protocols
- **HTTP/HTTPS**: 80/443 (ingress via LB)
- **App to DB**: DB port (e.g., 1433 for SQL Server, 3306 for MySQL) restricted to app subnet.
- **Cache**: Redis default port (6379) restricted to app subnet.

## Operational Runbook & Troubleshooting
- **App unreachable**
  - Check LB health probes and rules.
  - Check web server process and logs.
  - Validate DNS and firewall rules.
- **High latency**
  - Check app metrics, DB query times, cache hit ratio.
  - Inspect recent deployments and config changes.
- **High error rate**
  - Inspect application logs for stack traces.
  - Rollback recent deployment if necessary.

## Security Incident Response Notes
- **Immediate actions**: Isolate the affected nodes; rotate credentials and certificates if leaked; preserve logs for forensics.
- **Communication**: Inform internal security team and follow incident escalation procedures.

## Architecture Trade-offs & Notes
- **Simplicity vs. scale**: Monolith is simpler to deploy but harder to scale and maintain compared to microservices.
- **Faster iteration**: Single deployable artifact reduces cross-service coordination.
- **Risk**: A deploy or fault affects whole application; use canary/blue-green and robust testing to mitigate.

## Checklist (Pre-deploy)
- **Infra**: IaC in version control and successful plan/apply in non-prod
- **Secrets**: Stored and accessible via secure store
- **Backups**: Recent DB backup validated
- **Monitoring**: Alerts configured and paged to on-call
- **Tests**: Automated tests passed (unit + integration + smoke)

## Appendix — Useful Commands & Examples
- **Check load balancer health**: Use provider console or CLI (e.g., `az network lb` / `aws elbv2`) to inspect health probes.
- **Tail logs**: `az monitor log` or `kubectl logs -f` (if containerized) or remote into VM and `Get-Content -Wait` for Windows logs.

## References & Further Reading
- OWASP Top Ten
- Provider-specific docs: Azure Application Gateway, Azure Front Door, AWS ALB/CloudFront if applicable
- IaC docs: Terraform, ARM, Bicep
