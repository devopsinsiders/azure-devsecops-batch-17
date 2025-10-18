data "azurerm_service_plan" "this" {
  for_each = var.function_apps

  name                = each.value.app_service_plan_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_storage_account" "this" {
  for_each = var.function_apps

  name                = each.value.storage_account_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_linux_function_app" "this" {
  for_each = var.function_apps

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  storage_account_name       = data.azurerm_storage_account.this[each.key].name
  storage_account_access_key = data.azurerm_storage_account.this[each.key].primary_access_key
  service_plan_id            = data.azurerm_service_plan.this[each.key].id
  site_config {}
  https_only                      = try(each.value.https_only, false)
  daily_memory_time_quota         = try(each.value.daily_memory_time_quota, null)
  enabled                         = try(each.value.enabled, true)
  key_vault_reference_identity_id = try(each.value.key_vault_reference_identity_id, null)
  tags                            = try(each.value.tags, {})
}
