variable "name" {
  description = "(Required) The name of the Managed Kubernetes Cluster to create."
  type        = string
}

variable "location" {
  description = "(Required) The location where the Managed Kubernetes Cluster should be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist."
  type        = string
}

variable "default_node_pool" {
  description = "(Required) Configuration for the system node pool. See README for accepted attributes."
  type = object({
    name               = string
    node_count         = number
    vm_size            = string
    enable_auto_scaling = optional(bool)
    min_count          = optional(number)
    max_count          = optional(number)
    os_disk_size_gb    = optional(number)
    vnet_subnet_id     = optional(string)
    mode               = optional(string)
  })
}

variable "dns_prefix" {
  description = "(Optional) DNS prefix specified when creating the managed cluster. Either this or dns_prefix_private_cluster must be set."
  type        = string
  default     = null
}

variable "dns_prefix_private_cluster" {
  description = "(Optional) DNS prefix to use with private clusters. Either this or dns_prefix must be set."
  type        = string
  default     = null
}

variable "identity_type" {
  description = "(Optional) Identity type for the cluster (e.g. SystemAssigned, UserAssigned). One of this or service_principal must be provided."
  type        = string
  default     = ""
}

variable "user_assigned_identity_ids" {
  description = "(Optional) List of user assigned identity IDs to attach when using user assigned identities."
  type        = list(string)
  default     = []
}

variable "service_principal" {
  description = "(Optional) Service principal object when using service principal auth. Must be null if using managed identity. { client_id = string, client_secret = string }"
  type        = any
  default     = null
}

variable "kubernetes_version" {
  description = "(Optional) Kubernetes version to use for the cluster."
  type        = string
  default     = null
}

variable "private_cluster_enabled" {
  description = "(Optional) Should this cluster use a private API endpoint?"
  type        = bool
  default     = false
}

variable "private_dns_zone_id" {
  description = "(Optional) ID of Private DNS Zone to delegate to the cluster."
  type        = string
  default     = null
}

variable "node_resource_group" {
  description = "(Optional) Resource group name to create node resources in. Must be new/non-existent name."
  type        = string
  default     = null
}

variable "role_based_access_control_enabled" {
  description = "(Optional) Whether Role Based Access Control should be enabled."
  type        = bool
  default     = true
}

variable "oidc_issuer_enabled" {
  description = "(Optional) Enable OIDC issuer URL."
  type        = bool
  default     = false
}

variable "workload_identity_enabled" {
  description = "(Optional) Enable Azure AD Workload Identity. Requires oidc_issuer_enabled=true."
  type        = bool
  default     = false
}

variable "network_profile" {
  description = "(Optional) Network profile object - passed through to the resource as a simple map."
  type        = map(any)
  default     = {}
}

variable "api_server_access_profile" {
  description = "(Optional) API server access profile as a map."
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "(Optional) Tags to assign to the cluster."
  type        = map(string)
  default     = {}
}
