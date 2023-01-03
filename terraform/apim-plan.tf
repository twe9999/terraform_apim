resource "azurerm_api_management" "apim_mgt" {
  name                = format("apim-ixt-%s",var.env)
  resource_group_name = azurerm_resource_group.group_001.name
  location            = var.location
  publisher_name      = "ixtw"
  publisher_email     = "ixtw@admin"
  #
  sku_name = "Developer_1"

  tags = {
    group        = var.group,
    env          = var.env,
    location     = var.location
    subscription = var.subscription_id
  }
}