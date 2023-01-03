resource "azurerm_api_management_api" "demosvc" {
  name                = "demosvc"
  resource_group_name = azurerm_resource_group.group_001.name
  api_management_name = azurerm_api_management.apim_mgt.name
  revision            = "1"
  display_name        = "demosvc"
  description         = "DEMO服務"
  path                = "demosvc"
  service_url         = format("https://func-ixt-dxp-demo-%s.azurewebsites.net/api",var.env)
  protocols           = ["https"]
  subscription_required= false
}


resource "azurerm_api_management_api_policy" "demosvc" {
  api_name            = azurerm_api_management_api.demosvc.name
  api_management_name = azurerm_api_management_api.demosvc.api_management_name
  resource_group_name = azurerm_api_management_api.demosvc.resource_group_name
  xml_content = <<XML
<policies>
    <inbound>
        <base />
        <rate-limit calls="120" renewal-period="60" />
        
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML
}


resource "azurerm_api_management_api_operation" "checkip" {
  operation_id        = "checkip"
  display_name        = "checkip"
  url_template        = "/checkip"
  api_name            = azurerm_api_management_api.demosvc.name
  api_management_name = azurerm_api_management_api.demosvc.api_management_name
  resource_group_name = azurerm_api_management_api.demosvc.resource_group_name
  method              = "GET"
  response {
    status_code = 200
    description = "200"
    representation {
      content_type = "application/json"
      example {
        name = "default"
        value = jsonencode({
          response = "ok"
        })
      }
    }
  }
}


resource "azurerm_api_management_api_operation_policy" "checkip" {
  api_name            = azurerm_api_management_api_operation.checkip.api_name
  api_management_name = azurerm_api_management_api_operation.checkip.api_management_name
  resource_group_name = azurerm_api_management_api_operation.checkip.resource_group_name
  operation_id        = azurerm_api_management_api_operation.checkip.operation_id

  xml_content = <<XML
<policies>
    <inbound>
        <base />
      
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML

}

resource "azurerm_api_management_identity_provider_google" "checkip" {
  resource_group_name = azurerm_api_management_api_operation.checkip.resource_group_name
  api_management_name = azurerm_api_management_api_operation.checkip.api_management_name
  client_id           = "27425271650-qdmgb906h9t7bo685pcepkfmbsfbefgu.apps.googleusercontent.com"
  client_secret       = "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"
}

