# Storage Account Function
resource "azurerm_storage_account" "stroage_account_function" {
  name                     = format("stmgtfunc%s",var.env)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.group_001.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    group        = var.group,
    env          = var.env,
    location     = var.location
    subscription = var.subscription_id
  }
}

