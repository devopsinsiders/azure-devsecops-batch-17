variable "function_apps" {
  description = "A map of function app configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string

    app_service_plan_name = string
    storage_account_name  = string

    app_settings = optional(map(string), {})

    site_config = optional(object({
      always_on                 = optional(bool)
      ftps_state                = optional(string)
      use_32_bit_worker_process = optional(bool)
      linux_fx_version          = optional(string)
      scm_type                  = optional(string)
    }), {})

    https_only              = optional(bool, false)
    client_cert_mode        = optional(string)
    daily_memory_time_quota = optional(number)
    enabled                 = optional(bool, true)
    enable_builtin_logging  = optional(bool, true)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    key_vault_reference_identity_id = optional(string)
    os_type                         = optional(string)
    version                         = optional(string, "~1")
    tags                            = optional(map(string), {})
  }))
}
