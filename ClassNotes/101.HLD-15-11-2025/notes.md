# High-Level Design Notes

These notes summarize the architecture illustrated in the provided diagram and document design rationale, components, data flow, security, non-functional requirements, deployment recommendations, monitoring and operational runbooks.

## Overview
- **Purpose:** Outline a scalable, highly available, and secure 3-tier application architecture suitable for cloud deployment.
- **Primary goals:** High availability, horizontal scalability, secure network boundaries, observability, and automated deployment.

## Diagram Legend (mapping)
- **1 — Load Balancer / Ingress:** Public entry point for client traffic (TLS termination or pass-through).
- **2 — Web Tier (Stateless):** Front-end web servers or app gateway handling HTTP requests.
- **3 — App Tier (Business Logic):** Stateless application servers / microservices implementing core logic.
- **4 — Cache Layer (Optional):** In-memory caching (Redis/Memcached) for session or response caching.
- **5 — Data Layer:** Primary relational database (e.g., Azure SQL / PostgreSQL) with a read-replica tier.
- **6 — Blob/Object Storage:** For user uploads, assets, and backups.
- **7 — Messaging / Queue:** Asynchronous job processing (e.g., Azure Service Bus, RabbitMQ, or SQS).
- **8 — Monitoring & Logging:** Centralized telemetry (metrics, logs, traces).
- **9 — Bastion / Jumpbox:** Secure admin access into private network for maintenance.
- **Network:** Virtual network with public and private subnets, NAT/gateway, and Network Security Groups.

> Note: If the diagram uses different numbering or labels, map the diagram elements to the above by visual match.

## Components & Responsibilities
- **Ingress / Load Balancer**
  - Terminates TLS (preferably using managed certificates) and distributes traffic across web instances.
  - Enforces basic layer-7 routing rules (path-based routing to services).
  - Integrate WAF (Web Application Firewall) policies to block common web attacks.

- **Web Tier**
  - Stateless front-end instances behind the load balancer.
  - Autoscale based on CPU/RPS or request queue length.
  - Should be deployed in multiple availability zones for resilience.

- **Application Tier**
  - Hosts business logic, API endpoints, and service-to-service communication.
  - Containerized or VM-based; orchestrated by a container platform (AKS/ECS/EKS) or PaaS (App Service).
  - Use service mesh or API gateway for observability, security, and traffic control where appropriate.

- **Cache Layer**
  - Short-lived caching for performance; session store if sessions needed.
  - Use TLS and access controls; keep data non-critical (evictable) or backed by durable storage.

- **Data Layer**
  - Primary transactional DB with automated backups, point-in-time recovery, encryption at rest.
  - Read replicas for read-heavy workloads; failover configured for HA.
  - Consider separation of analytical workloads into a separate data warehouse.

- **Blob/Object Storage**
  - Store large objects, logs archives, and static assets.
  - Use lifecycle policies (cold storage) to reduce cost.

- **Messaging / Queue**
  - Decouple synchronous flows; enable retries and dead-letter handling.
  - Use visibility timeouts and idempotent processors.

- **Monitoring & Logging**
  - Collect metrics (CPU, memory, latency), logs, and distributed traces.
  - Centralize logs and set alerting based on SLOs and error budgets.

- **Security & Access**
  - Use least privilege IAM roles for all services.
  - Secure secrets via a vault service (Key Vault / Secrets Manager), and avoid in-VM secrets.
  - Network Security Groups to restrict traffic between tiers: only allow expected ports and sources.
  - Implement TLS for all in-transit communication; enable encryption at rest for storage and DB.

## Network Design
- **VNet segmentation:** Public subnet(s) for load balancer; private subnets for web, app, and data tiers.
- **NSG rules:** Explicit allow rules for required service ports; deny by default otherwise.
- **Private endpoints:** Use private endpoints for data services where possible to avoid exposing DB to the internet.
- **Bastion host:** Access admin consoles via a bastion; audit all admin logins.
- **Gateway / Transit:** If hybrid connectivity required, configure VPN or ExpressRoute with proper routing and firewalling.

## Data Flow (high level)
1. Client -> TLS -> Load Balancer / WAF
2. Load Balancer -> Web Tier (scale-out stateless instances)
3. Web Tier -> App Tier for business logic and data operations
4. App Tier -> Cache for reads; fallback to DB when miss
5. App Tier -> Messaging service for async tasks
6. App Tier -> Data Layer (primary DB) for persistent storage
7. Background workers consume messages, update DB, store artifacts to Blob Storage
8. Monitoring agents send logs/metrics to centralized telemetry

## Non-Functional Requirements
- **Availability:** Multi-AZ deployment, health probes, and automated failover for DB.
- **Scalability:** Autoscaling rules based on meaningful metrics (RPS, queue length, CPU). Stateless tiers scale easily.
- **Performance:** Use CDN for static assets and caching layers for read-heavy endpoints.
- **Security:** Strong authentication (OIDC/SAML), RBAC for management plane, WAF for application plane.
- **Durability & Backup:** Regular DB backups, snapshots for critical systems, and replicated storage.
- **Compliance:** Ensure encryption, access logging, and retention meet regulatory requirements.

## Deployment & IaC
- **Infrastructure as Code:** Use Terraform/ARM/Bicep to define network, compute, DB, storage, and managed services.
- **CI/CD pipeline:** Build -> test -> image artifact -> deploy to staging -> manual approval -> deploy to production.
- **Environments:** Keep dev, test, staging, and prod isolated with their own resource groups/subscriptions as needed.
- **Immutable deployments:** Prefer blue/green or canary deployments for zero-downtime releases.

## Monitoring, Alerting & SLOs
- **Metrics:** Request latency (p50/p95/p99), error rate, CPU/memory, DB connections, queue length.
- **Alerts:** Thresholds for error rate spikes, high latency, high queue backlog, failed deployments, and infrastructure health.
- **Tracing & Logs:** Distributed tracing for cross-service request flows; centralized logging with retention policies.
- **SLOs:** Define uptime targets (e.g., 99.9%), latency targets per endpoint, and error budgets.

## Backup, DR & Recovery
- **Backup frequency:** Daily automated DB backups plus periodic full snapshots depending on RTO/RPO.
- **DR strategy:** Geo-replication or failover with tested runbooks.
- **Recovery tests:** Schedule periodic restore drills and verify integrity.

## Operational Runbook (high level)
- **Deploy rollback:** Steps to rollback a release via CI/CD or DNS switch for blue/green.
- **Scale up/down:** How to adjust autoscale settings, and manual scale steps in emergency.
- **DB failover:** Steps to initiate/verify DB failover and bring up read-only replicas.
- **Incident response:** Contact list, escalate criteria, runbook for common incidents (high latency, service down, data breach).

## Cost Considerations
- Use reserved instances or savings plans for predictable workloads.
- Right-size resources and use autoscaling to reduce waste.
- Use tiered storage lifecycle rules for blob data to optimize cost.

## Security Hardening Checklist
- Enforce MFA for all admin roles.
- Enable encryption at rest for DB and storage.
- Use private endpoints for management and DB where possible.
- Regular vulnerability scanning and patching for images/OS.
- Rotate secrets and audit usage via Key Vault logs.

## Assumptions
- The diagram represents a cloud-native deployment (public cloud provider).
- Application tiers are stateless or made stateless for scaling.
- Managed services (DB, cache, messaging) are available and preferred over self-managed.
- Network zones correspond to availability zones for resiliency.

## Open Questions / Items for Clarification
- Expected peak RPS and data volume (to size instances and storage).
- Recovery time objective (RTO) and recovery point objective (RPO) targets.
- Whether the app requires strong consistency or eventual consistency for certain flows.
- Compliance/regulatory constraints (data residency, encryption standards).
- Preference for container orchestration vs PaaS.

## Next Steps / Recommendations
- Validate assumptions with stakeholders (peak load, RTO/RPO).
- Convert diagram to IaC modules (network, compute, data, security) and create a staging environment.
- Add concrete SLOs and create alerting playbooks.
- Run DR tests and scale validation under load.

## References
- Diagram file: `ClassNotes/101.HLD-15-11-2025/diagram.pdf`
- Suggested IaC tools: Terraform, Bicep, ARM
- Suggested monitoring: Prometheus/Grafana, or cloud-native monitoring (Azure Monitor / Application Insights)

