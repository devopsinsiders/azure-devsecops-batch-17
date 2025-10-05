variable "cost_center" {}
variable "owner" {}
variable "team_name" {}
variable "storage_accounts" {
  type = map(object(
    {
      name                            = string
      resource_group_name             = string
      location                        = string
      account_tier                    = string
      account_replication_type        = string
      public_network_access_enabled   = optional(bool, false)
      is_hns_enabled                  = optional(bool, true)
      nfsv3_enabled                   = optional(bool, true)
      shared_access_key_enabled       = optional(bool, false)
      min_tls_version                 = optional(string, "TLS1_2")
      allow_nested_items_to_be_public = optional(bool, true)
      default_to_oauth_authentication = optional(bool, false)
      https_traffic_only_enabled      = optional(bool, true)
      access_tier                     = optional(string, "Hot")
  }))
}

locals {
  common_tags = {
    cost_center = var.cost_center
    owner       = var.owner
    team_name   = var.team_name
  }
}

resource "azurerm_storage_account" "storage_account" {
  for_each = var.storage_accounts

  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  account_tier                    = each.value.account_tier
  access_tier                     = each.value.access_tier
  account_replication_type        = each.value.account_replication_type
  public_network_access_enabled   = each.value.public_network_access_enabled
  is_hns_enabled                  = each.value.is_hns_enabled
  nfsv3_enabled                   = each.value.nfsv3_enabled
  shared_access_key_enabled       = each.value.shared_access_key_enabled
  min_tls_version                 = each.value.min_tls_version
  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public
  default_to_oauth_authentication = each.value.default_to_oauth_authentication
  https_traffic_only_enabled      = each.value.https_traffic_only_enabled
  tags                            = local.common_tags

  network_rules {
    default_action = "Allow"
    ip_rules       = each.value.network_rules.allow_public_ip
  }

  lifecycle {
    prevent_destroy = true
  }
}
