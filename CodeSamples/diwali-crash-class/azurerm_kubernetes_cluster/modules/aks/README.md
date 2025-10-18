# AKS Module

This module creates an Azure Kubernetes Service cluster (`azurerm_kubernetes_cluster`) and aims to be a lightweight, generic wrapper that supports being instantiated multiple times with `for_each`.

Inputs (selected):
- `name` (string) - cluster name
- `location` (string) - location
- `resource_group_name` (string) - resource group
- `default_node_pool` (object) - default/system node pool configuration (name, node_count, vm_size, optional os_disk_size_gb, vnet_subnet_id)
- `dns_prefix` (string) - dns prefix or `dns_prefix_private_cluster`
- `identity_type` (string) - e.g. `SystemAssigned` or `UserAssigned`
- `service_principal` (object|null) - use when not using managed identity
- `kubernetes_version` (string)
- `tags` (map)

Outputs:
- `id`, `fqdn`, `kube_config`

Example root usage (see parent `main.tf`) shows creating multiple clusters using a `map` variable and `for_each` on the module.
