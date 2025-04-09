# Class Notes: Azure Storage Account, Region and Zones, Redundancy, Terraform State File, Remote Backend Configuration, State Locking

## 1. Azure Storage Account

- Azure Storage Account is a cloud storage solution provided by Microsoft Azure.
- It offers several types of storage services:
  - Blob storage: Used for storing large amounts of unstructured data, such as text or binary data.
  - File share: Provides shared access to files with the SMB protocol.
  - Table storage: NoSQL data store for storing structured datasets.
  - Queue storage: Messaging store for reliable messaging between application components.
- Each type serves different purposes and is suitable for different scenarios.

## 2. Region and Zones

- Azure is divided into geographical regions, each containing one or more datacenters.
- Regions are important for ensuring data residency, compliance, and high availability.
- Within each region, Azure datacenters are further divided into availability zones.
- Availability zones are physically separate locations within an Azure region, each with independent power, cooling, and networking.
- Deploying resources across availability zones increases resilience against datacenter failures.

## 3. Redundancy - LRS, ZRS, GRS

- Redundancy options in Azure Storage Account ensure data durability and availability.
- Locally Redundant Storage (LRS): Data is replicated within a single datacenter.
- Zone-Redundant Storage (ZRS): Data is replicated across multiple availability zones in the same region.
- Geo-Redundant Storage (GRS): Data is replicated to a secondary region, providing data redundancy across regions for disaster recovery.

## 4. Terraform State File

- Terraform state file is a JSON-formatted file that keeps track of the resources managed by Terraform.
- It stores metadata about the resources, their dependencies, and their properties.
- The state file is crucial for Terraform to understand the current state of the infrastructure and to plan and apply changes accurately.

## 5. Setting Remote Backend in Azure Storage Account

```hcl
backend "azurerm" {
  resource_group_name  = "rg-titumama-1"
  storage_account_name = "sadevopsinsiders123"
  container_name       = "terraform-state"
  key                  = "dhondhu.terraform.tfstate"
}
```

- This configuration sets up Azure Storage Account as the remote backend for Terraform.
- It specifies the Azure resource group, storage account, container, and key (filename) for storing the state file remotely.

## 6. How State Locking Works?

- State locking prevents concurrent operations on the same Terraform state file to avoid conflicts.
- When Terraform performs an operation, it acquires a lock on the state file.
- Locking mechanisms include file locking (local state file) and remote locking (using a backend like Azure Storage Account).
- Concurrent operations from different users or automation systems will wait until the lock is released.
- Locks are automatically released after successful completion or timeout to prevent deadlocks.