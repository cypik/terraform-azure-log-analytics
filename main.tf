module "labels" {
  source      = "cypik/labels/azure"
  version     = "1.0.3"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}

resource "azurerm_log_analytics_workspace" "main" {
  count               = var.enabled && var.create_log_analytics_workspace ? 1 : 0
  name                = coalesce(var.log_analytics_workspace_name, format("%s-logs", module.labels.id))
  location            = var.log_analytics_workspace_location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.retention_in_days
  daily_quota_gb      = var.daily_quota_gb

  allow_resource_only_permissions         = var.allow_resource_only_permissions
  local_authentication_enabled            = var.local_authentication_enabled
  cmk_for_query_forced                    = var.cmk_for_query_forced
  reservation_capacity_in_gb_per_day      = var.reservation_capacity_in_gb_per_day
  data_collection_rule_id                 = var.data_collection_rule_id
  immediate_data_purge_on_30_days_enabled = var.immediate_data_purge_on_30_days_enabled

  internet_ingestion_access_type = var.internet_ingestion_access_type
  internet_query_access_type     = var.internet_query_access_type

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = lookup(identity.value, "type", "SystemAssigned")
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  tags = module.labels.tags

  lifecycle {
    ignore_changes = [
      tags,
      daily_quota_gb,
    ]
  }

  timeouts {
    create = "30m"
    read   = "5m"
    update = "30m"
    delete = "30m"
  }
}



resource "azurerm_monitor_diagnostic_setting" "test" {
  count                          = var.enabled && var.diagnostic_setting_enable ? 1 : 0
  name                           = format("%s-log-analytics-diagnostic-log", module.labels.id)
  target_resource_id             = join("", azurerm_log_analytics_workspace.main[*].id)
  storage_account_id             = var.storage_account_id
  partner_solution_id            = var.partner_solution_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "enabled_log" {
    for_each = var.enabled_logs
    content {
      category       = lookup(enabled_log.value, "category", null)
      category_group = lookup(enabled_log.value, "category_group", null)
    }
  }

  dynamic "enabled_metric" {
    for_each = var.enabled_metrics
    content {
      category = lookup(enabled_metric.value, "category", null)
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}