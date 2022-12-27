resource "azurerm_linux_function_app" "function_demo" {
  name                       = format("func-ixt-dxp-demo-%s",var.env)
  resource_group_name        = azurerm_resource_group.group_001.name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.plan_consumption_function.id
  storage_account_name       = azurerm_storage_account.stroage_account_function.name
  storage_account_access_key = azurerm_storage_account.stroage_account_function.primary_access_key
  site_config {
    application_stack {
      node_version                   = "14"
    }
    ftps_state               = "FtpsOnly"
    cors {
      support_credentials    = true
      allowed_origins        =  [
        "http://127.0.0.1:3000",
        "http://localhost:3000",
        "http://127.0.0.1:4500",
        "http://localhost:4500",
        "http://127.0.0.1:5000",
        "http://localhost:5000"
      ]
    }
    application_insights_key               = azurerm_application_insights.appinsights.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.appinsights.connection_string
  }
  
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "node"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.appinsights.instrumentation_key
    "NODE_ENV"                       = var.node_env
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_ENABLE_SYNC_UPDATE_SITE"],
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      app_settings["WEBSITE_MOUNT_ENABLED"],
      app_settings["APPINSIGHTS_INSTRUMENTATIONKEY"],
    ]
  }

  tags = {
    group        = var.group,
    env          = var.env,
    location     = var.location
    subscription = var.subscription_id
  }
}