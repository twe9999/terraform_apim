########################################################################
## 基本資訊
########################################################################
output "group_001" {
  value = azurerm_resource_group.group_001.name
}
output "instrumentation_key" {
  value     = azurerm_application_insights.appinsights.instrumentation_key
  sensitive = true
}
output "app_insight_name" {
  value = azurerm_application_insights.appinsights.name
}

