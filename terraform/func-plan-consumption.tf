####################################################
### Consumption Plan
####################################################
resource "azurerm_service_plan" "plan_consumption_function" {
  name                = format("plan-ixt-func-%s",var.env)
  resource_group_name = azurerm_resource_group.group_001.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
  tags = {
    group        = var.group,
    env          = var.env,
    location     = var.location
    subscription = var.subscription_id
  }
}