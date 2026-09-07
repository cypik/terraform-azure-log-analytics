
#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/cypik/terraform-azure-log-analytics"
  description = "Terraform current module repo"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = "Cypik"
  description = "ManagedBy, eg 'cypik'."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "log_analytics_workspace_location" {
  type        = string
  default     = "West Us"
  description = "Location of the Workspace"
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group of deployment"
}

variable "log_analytics_workspace_sku" {
  type        = string
  default     = "PerGB2018"
  description = "pecifies the Sku of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new Sku as of 2018-04-03). Defaults to PerGB2018"

}

variable "create_log_analytics_workspace" {
  type        = bool
  default     = true
  description = "The Flag for Module Enable or Disabled if it will false it will take `existing_log_analytics_workspace`."
}

variable "retention_in_days" {
  type        = number
  default     = null
  description = "The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
}
variable "daily_quota_gb" {
  type        = string
  default     = "-1"
  description = "The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted."
}

variable "internet_ingestion_access_type" {
  type        = string
  default     = "Enabled"
  description = "The type of access for the Log Analytics Workspace ingestion over the Public Internet. Possible values are `Enabled` and `Disabled`. Defaults to `Enabled`."
}
variable "internet_query_access_type" {
  type        = string
  default     = "Enabled"
  description = "The type of access for the Log Analytics Workspace querying over the Public Internet. Possible values are `Enabled` and `Disabled`. Defaults to `Enabled`."
}
#### enable diagnostic setting
variable "log_analytics_destination_type" {
  type        = string
  default     = "AzureDiagnostics"
  description = "Possible values are AzureDiagnostics and Dedicated, default to AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
}

variable "diagnostic_setting_enable" {
  type    = bool
  default = true
}

variable "storage_account_id" {
  type        = string
  default     = null
  description = "The ID of the Storage Account where logs should be sent."
}
variable "eventhub_name" {
  type        = string
  default     = null
  description = "Specifies the name of the Event Hub where Diagnostics Data should be sent."
}
variable "eventhub_authorization_rule_id" {
  type        = string
  default     = null
  description = "Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data."
}



variable "enabled_logs" {
  description = "List of diagnostic logs to enable"
  type = list(object({
    category       = optional(string)
    category_group = optional(string)
  }))
  default = [
    {
      category       = null
      category_group = "AllLogs"
    }
  ]
}


variable "enabled_metrics" {
  description = "List of diagnostic metrics to enable"
  type = list(object({
    category = string
  }))
  default = [
    {
      category = "AllMetrics"
    }
  ]
}

variable "log_analytics_workspace_name" {
  type        = string
  default     = null
  description = "Custom name for the Log Analytics Workspace (optional)"
}

variable "identity" {
  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string))
  })
  default = null
}


variable "allow_resource_only_permissions" {
  type    = bool
  default = true
}

variable "local_authentication_enabled" {
  type    = bool
  default = true
}

variable "cmk_for_query_forced" {
  type    = bool
  default = false
}

variable "reservation_capacity_in_gb_per_day" {
  type        = number
  default     = null
  description = "Valid only when SKU is CapacityReservation"
}

variable "data_collection_rule_id" {
  type    = string
  default = null
}

variable "immediate_data_purge_on_30_days_enabled" {
  type    = bool
  default = false
}

variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "partner_solution_id" {
  type        = string
  default     = null
  description = "The ID of the Storage Account where logs should be sent."
}