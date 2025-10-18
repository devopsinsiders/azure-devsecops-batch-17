resource "azurerm_service_plan" "asp" {
  for_each = var.service_plans

  name                = each.value.name
  location            = each.value.location
  os_type             = each.value.os_type
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name

  app_service_environment_id       = each.value.app_service_environment_id
  premium_plan_auto_scale_enabled  = each.value.premium_plan_auto_scale_enabled
  maximum_elastic_worker_count     = each.value.maximum_elastic_worker_count
  worker_count                     = each.value.worker_count
  per_site_scaling_enabled         = each.value.per_site_scaling_enabled
  zone_balancing_enabled           = each.value.zone_balancing_enabled
  tags                             = each.value.tags
}
