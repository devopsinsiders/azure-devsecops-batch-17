# Comprehensive Notes – Azure Enterprise 3-Tier Architecture, Terraform & DevOps Lifecycle

---

# 1. Introduction

The document explains:

* Enterprise-grade Azure Infrastructure
* Monolithic vs Microservices architecture
* DevOps lifecycle
* Terraform Infrastructure as Code
* Azure networking
* Multi-region deployment
* Security & governance
* CI/CD pipelines
* Disaster recovery
* Monitoring and observability
* AKS and deployment strategies

The overall goal is:

> Build a scalable, secure, highly available, cost-effective (“Sasta Sundar Tikau”) enterprise infrastructure on Azure Cloud.

---

# 2. Monolithic vs Microservices Architecture

## Monolithic Architecture

In monolithic architecture:

* Entire application is deployed as one single unit
* Frontend + Backend + Database tightly connected
* One codebase
* One deployment package

### Characteristics

* Tightly coupled
* Easier initially
* Difficult scaling
* Difficult deployments
* One failure may impact whole application

### Example Repositories

Frontend:

* [ReactTodoUIMonolith](https://github.com/devopsinsiders/ReactTodoUIMonolith?utm_source=chatgpt.com)

Backend:

* [PyTodoBackendMonolith](https://github.com/devopsinsiders/PyTodoBackendMonolith?utm_source=chatgpt.com)

---

## Microservices Architecture

In microservices architecture:

* Application broken into smaller services
* Each service independently deployable
* Loosely coupled

### Characteristics

* Independent scaling
* Better fault isolation
* Faster deployments
* Easier maintenance
* Complex networking

### Example Repositories

Frontend:

* [MicroTodoUI](https://github.com/devopsinsiders/MicroTodoUI?utm_source=chatgpt.com)

Microservices:

* [DeleteTaskTodoMicroservice](https://github.com/devopsinsiders/DeleteTaskTodoMicroservice?utm_source=chatgpt.com)
* [AddTaskTodoMicroservice](https://github.com/devopsinsiders/AddTaskTodoMicroservice?utm_source=chatgpt.com)
* [GetTasksTodoMicroservice](https://github.com/devopsinsiders/GetTasksTodoMicroservice?utm_source=chatgpt.com)

---

# 3. Software Development Lifecycle (SDLC)

## Step 1 – Requirement Gathering

Business team gathers requirements.

Documents created:

### SOW (Statement of Work)

Defines:

* Scope
* Timeline
* Deliverables
* Budget

### BRD (Business Requirement Document)

Contains:

* Business requirements
* Functional expectations
* Business goals

---

## Step 2 – Functional Document

Functional behavior of application explained.

Includes:

* Features
* APIs
* User behavior
* Validations

---

## Step 3 – HLD (High Level Design)

Architect decides:

* Cloud platform
* Network design
* Security
* High-level architecture
* DR strategy

---

## Step 4 – LLD (Low Level Design)

Detailed implementation-level design.

Includes:

* IP ranges
* Subnets
* NSG rules
* VM sizing
* Ports
* Storage
* Resource names

---

# 4. Agile Planning

## Epic Creation

Large feature = Epic

Example:

* User Management
* Payment System
* Monitoring

---

## User Stories

Epic divided into smaller stories.

Example:

* Create Login Page
* Add Forgot Password
* Create API

---

## Sprint Planning

Team plans:

* Tasks
* Timelines
* Assignments

Usually:

* 2 weeks sprint

---

# 5. DevOps Implementation Phase

Implementation includes:

* Infrastructure setup
* Pipelines
* Security
* Deployment
* Monitoring

---

# 6. Azure Landing Zone

Landing Zone = Foundation of Azure Environment

It includes:

* Governance
* Networking
* Identity
* Security
* Policies
* DR
* Monitoring

---

## Hub and Spoke Architecture

### Hub

Contains centralized services:

* Firewall
* VPN
* Bastion
* Monitoring

### Spoke

Contains workloads:

* Applications
* Databases
* APIs

Benefits:

* Centralized security
* Isolation
* Scalability

---

# 7. Enterprise Governance

## Identity Management

### Microsoft Entra ID

Used for:

* Authentication
* Authorization
* User management

---

## MFA (Multi Factor Authentication)

Extra security layer.

Example:

* Password + OTP

---

## Conditional Access

Policies like:

* Allow office IP only
* Block risky logins

---

## PIM (Privileged Identity Management)

Temporary admin access.

Improves security.

---

## RBAC (Role Based Access Control)

Access based on roles.

Example:

* Reader
* Contributor
* Owner

---

## Managed Identity

Azure-managed service identity.

Used to securely access:

* Key Vault
* Storage
* Databases

Without storing passwords.

---

# 8. Azure Networking Components

---

# Virtual Network (VNet)

Private isolated Azure network.

Acts like:

> Data center network in cloud

---

# Subnet

Subdivision of VNet.

Used to isolate:

* Frontend
* Backend
* Database

---

# NSG (Network Security Group)

Controls traffic.

Rules:

* Inbound
* Outbound

Acts like firewall.

---

# Route Table

Controls packet routing.

---

# Azure Firewall

Enterprise centralized firewall.

Features:

* Threat filtering
* DNAT
* Application rules
* Network rules

---

# Azure Bastion

Secure VM access through browser.

No public SSH/RDP needed.

---

# VPN Gateway

Connects:

* On-premise ↔ Azure

---

# ExpressRoute

Dedicated private connection to Azure.

Very secure and low latency.

---

# VNet Peering

Connect VNets privately.

### Same Region

* VNet Peering

### Different Region

* Global VNet Peering

---

# Application Gateway

Layer 7 Load Balancer.

Features:

* WAF
* SSL termination
* URL routing

---

# Load Balancer

Layer 4 Load Balancer.

Works on:

* TCP
* UDP

---

# Front Door

Global Layer 7 load balancing.

Features:

* Global routing
* Failover
* CDN
* SSL offloading

---

# Traffic Manager

DNS-based global traffic routing.

---

# Private Endpoint

Private connectivity to PaaS services.

No internet exposure.

---

# DDoS Protection

Protects against:

* Flood attacks
* Volumetric attacks

---

# 9. Compute Services

## Virtual Machines

IaaS servers.

---

## VMSS (Virtual Machine Scale Sets)

Auto scaling VM groups.

---

## App Service

PaaS hosting.

---

## Azure Functions

Serverless compute.

Pay only when executed.

---

## Azure Container Instances

Run containers directly.

---

## Azure Logic Apps

Workflow automation service.

---

## Azure Kubernetes Service (AKS)

Managed Kubernetes cluster.

Used for:

* Microservices
* Containers
* Scaling

---

# 10. Storage Services

## Storage Account

Provides:

* Blob Storage
* File Share
* Queue
* Table Storage

---

## Data Lake Gen2

Big data analytics storage.

---

# 11. Database Services

## Azure SQL Database

Managed relational DB.

---

## SQL Managed Instance

More SQL Server compatibility.

---

## Cosmos DB

NoSQL globally distributed DB.

---

## PostgreSQL / MySQL

Managed open-source databases.

---

## Redis Cache

In-memory cache.

---

# 12. Security Services

## Microsoft Defender

Threat detection.

---

## Microsoft Sentinel

SIEM solution.

---

## Key Vault

Stores:

* Secrets
* Certificates
* Passwords

---

## Azure Policy

Governance enforcement.

---

## Azure Blueprint

Standardized environment templates.

---

# 13. Monitoring Services

## Azure Monitor

Collects metrics/logs.

---

## Log Analytics Workspace

Centralized log storage.

---

## Application Insights

Application performance monitoring.

---

## Alerts and Dashboards

Operational visibility.

---

# 14. Backup and Disaster Recovery

## Azure Site Recovery

VM disaster recovery.

---

## Recovery Services Vault

Stores backups.

---

## Geo Redundant Storage

Cross-region replication.

---

# 15. Multi-Region 3-Tier Architecture

Architecture deployed in:

* India Region (Primary)
* USA Region (DR)

---

# 16. 3-Tier Application Architecture

Three layers:

| Layer    | Purpose        |
| -------- | -------------- |
| Frontend | UI             |
| Backend  | Business logic |
| Database | Data           |

---

# 17. Network Flow

User Flow:

Users → Front Door → Application Gateway → Frontend → Backend → Database

---

# 18. Subnet Design

## India Region

| Subnet   | CIDR         |
| -------- | ------------ |
| Frontend | 10.10.1.0/24 |
| Backend  | 10.10.2.0/24 |
| Database | 10.10.3.0/24 |
| Bastion  | 10.10.4.0/27 |
| Gateway  | 10.10.5.0/27 |
| Firewall | 10.10.6.0/26 |

---

## USA Region

| Subnet   | CIDR         |
| -------- | ------------ |
| Frontend | 10.20.1.0/24 |
| Backend  | 10.20.2.0/24 |
| Database | 10.20.3.0/24 |
| Bastion  | 10.20.4.0/27 |
| Gateway  | 10.20.5.0/27 |
| Firewall | 10.20.6.0/26 |

---

# 19. Traffic Flow Explained

## Step-by-Step

1. User opens application
2. Front Door receives request
3. Front Door checks healthy region
4. Traffic forwarded to App Gateway
5. WAF inspection happens
6. Request forwarded to Frontend VM
7. Frontend communicates with Backend
8. Backend accesses DB
9. Response returned

---

# 20. NSG Rules

## Frontend NSG

Allows:

* HTTPS 443

Blocks:

* Everything else

---

## Backend NSG

Allows:

* Frontend → Backend

---

## Database NSG

Allows:

* Backend → Database

Blocks:

* Internet access

---

# 21. Azure Bastion

Provides:

* Secure SSH
* Secure RDP

No public IP required on VMs.

---

# 22. Key Vault Secrets

Stores:

* DB passwords
* API keys
* Certificates
* Service principal secrets

---

# 23. Compute Layer Design

## Frontend VM

Purpose:

* NGINX
* React UI

---

## Backend VM

Purpose:

* APIs
* Business logic

---

## Database VM

Purpose:

* MySQL
* PostgreSQL
* SQL Server

---

# 24. Load Balancing

## Front Door

Global load balancing.

Handles:

* Failover
* Routing

---

## Application Gateway

Layer 7 load balancer.

Provides:

* WAF
* SSL Offload
* URL Routing

---

## Internal Load Balancer

Backend internal traffic balancing.

---

# 25. Disaster Recovery Strategy

## Active-Passive

### India

Primary Region

### USA

DR Region

Automatic failover via Front Door.

---

# 26. Monitoring and Logging

Logs collected:

* Firewall logs
* NSG flow logs
* VM logs
* App logs

Tools:

* Azure Monitor
* Log Analytics
* Grafana
* Prometheus
* Datadog

---

# 27. Terraform Architecture

Terraform repository structure:

```text
terraform/
├── modules/
├── env/
├── backend.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── main.tf
```

---

# 28. Parent and Child Modules

## Parent Module

Calls child modules.

Example:

* Network module
* VM module
* Firewall module

---

## Child Modules

Reusable modules.

Benefits:

* Reusability
* Standardization
* Scalability

---

# 29. Terraform Backend

Remote state stored in Azure Storage Account.

Benefits:

* Team collaboration
* State locking
* Centralized state

Example:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "prodtfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
```

---

# 30. Generic Terraform Modules

Terraform features used:

* for_each
* map
* dynamic blocks
* conditionals
* optional attributes

To create:

* Reusable modules
* Enterprise-ready code

---

# 31. Terraform Pipeline Flow

## Steps

1. Developer creates PR
2. Validation pipeline runs
3. Linting runs
4. Security scanning runs
5. Terraform Plan runs
6. Approval
7. Terraform Apply

---

# 32. Security Tools

## tfsec

Terraform security scanner.

---

## Trufflehog

Secrets detection.

---

## Super-Linter

Code quality checks.

---

## Infracost

Cost estimation.

---

## Terratest

Terraform testing.

---

## Chef InSpec

Compliance testing.

---

# 33. Branching Strategy

## Trunk Based Development

Single main branch.

Benefits:

* Faster integration
* Smaller PRs
* Faster delivery

---

# 34. CI/CD Pipelines

Tools:

* Azure DevOps Pipelines
* GitHub Actions

---

# 35. Azure Service Connection

Used to connect:

* Azure DevOps ↔ Azure Subscription

Authentication methods:

* Service Principal
* Workload Identity Federation

---

# 36. YAML Pipeline Structure

Pipeline contains:

* Stages
* Jobs
* Steps

---

# 37. Deployment Strategies

## Blue-Green Deployment

Two environments:

* Blue
* Green

Switch traffic after validation.

---

## Canary Deployment

Deploy to small percentage first.

Gradually increase traffic.

---

# 38. AKS in Enterprise Environment

AKS used for:

* Microservices
* Autoscaling
* Container orchestration

Benefits:

* High availability
* Rolling updates
* Self-healing
* DevOps integration

---

# 39. Best Practices

## Security

* No public SSH/RDP
* Use Bastion
* Use Key Vault
* Enable WAF
* Enable NSG flow logs

---

## Operations

* Use IaC
* Enable tagging
* Separate environments
* Use remote state
* Enable monitoring

---

# 40. Important Interview Questions

## Difference between Front Door and Application Gateway?

| Front Door      | Application Gateway |
| --------------- | ------------------- |
| Global          | Regional            |
| Layer 7         | Layer 7             |
| CDN support     | No CDN              |
| Global failover | Regional routing    |

---

## Difference between NSG and Firewall?

| NSG              | Firewall           |
| ---------------- | ------------------ |
| Basic filtering  | Advanced filtering |
| Subnet/NIC level | Centralized        |
| Free             | Paid               |

---

## Why use Bastion?

Secure VM access without exposing RDP/SSH publicly.

---