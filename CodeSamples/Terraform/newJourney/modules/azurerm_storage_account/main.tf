resource "azurerm_storage_account" "stg" {
  for_each = var.storage_accounts

  # Simple wala Arguments
  name                     = each.value.name
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  account_kind                      = each.value.account_kind
  provisioned_billing_model_version = each.value.provisioned_billing_model_version
  cross_tenant_replication_enabled  = each.value.cross_tenant_replication_enabled
  access_tier                       = each.value.access_tier
  edge_zone                         = each.value.edge_zone
  https_traffic_only_enabled        = each.value.https_traffic_only_enabled
  min_tls_version                   = each.value.min_tls_version
  allow_nested_items_to_be_public   = each.value.allow_nested_items_to_be_public
  shared_access_key_enabled         = each.value.shared_access_key_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  default_to_oauth_authentication   = each.value.default_to_oauth_authentication
  is_hns_enabled                    = each.value.is_hns_enabled
  nfsv3_enabled                     = each.value.nfsv3_enabled
  large_file_share_enabled          = each.value.large_file_share_enabled
  local_user_enabled                = each.value.local_user_enabled
  queue_encryption_key_type         = each.value.queue_encryption_key_type
  table_encryption_key_type         = each.value.table_encryption_key_type
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  allowed_copy_scope                = each.value.allowed_copy_scope
  sftp_enabled                      = each.value.sftp_enabled
  dns_endpoint_type                 = each.value.dns_endpoint_type
  tags                              = each.value.tags

  # Blocks wala Arguments
  dynamic "network_rules" {
    for_each = each.value.network_rules
    content {
      default_action = network_rules.value.default_action
      bypass         = network_rules.value.bypass
      ip_rules       = network_rules.value.ip_rules
    }
  }
}
