variable "service_plans" {
  type = map(object({
    name                = string
    location            = string
    os_type             = string
    resource_group_name = string
    sku_name            = string

    # Optional fields
    app_service_environment_id      = optional(string)
    premium_plan_auto_scale_enabled = optional(bool)
    maximum_elastic_worker_count    = optional(number)
    worker_count                    = optional(number)
    per_site_scaling_enabled        = optional(bool)
    zone_balancing_enabled          = optional(bool)
    tags                            = optional(map(string))
  }))
}
