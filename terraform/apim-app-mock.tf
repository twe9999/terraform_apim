resource "azurerm_api_management_api" "demomock" {
  name                = "demomock"
  resource_group_name = azurerm_resource_group.group_001.name
  api_management_name = azurerm_api_management.apim_mgt.name
  revision            = "1"
  display_name        = "demomock"
  description         = "DEMO服務"
  path                = "demomock"
  protocols           = ["https"]
  subscription_required= false
}


resource "azurerm_api_management_api_policy" "demomock" {
  api_name            = azurerm_api_management_api.demomock.name
  api_management_name = azurerm_api_management_api.demomock.api_management_name
  resource_group_name = azurerm_api_management_api.demomock.resource_group_name
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


resource "azurerm_api_management_api_operation" "mock" {
  operation_id        = "mock"
  display_name        = "mock"
  url_template        = "/mock"
  api_name            = azurerm_api_management_api.demomock.name
  api_management_name = azurerm_api_management_api.demomock.api_management_name
  resource_group_name = azurerm_api_management_api.demomock.resource_group_name
  method              = "GET"
  response {
    status_code = 200
    description = "200"
    representation {
      content_type = "application/json"
      example {
        name = "default"
        value = jsonencode({
          response = "resp mock data success"
        })
      }
    }
  }
}

resource "azurerm_api_management_api_operation_policy" "mock" {
  api_name            = azurerm_api_management_api_operation.mock.api_name
  api_management_name = azurerm_api_management_api_operation.mock.api_management_name
  resource_group_name = azurerm_api_management_api_operation.mock.resource_group_name
  operation_id        = azurerm_api_management_api_operation.mock.operation_id

  xml_content = <<XML
<policies>
    <inbound>
        <base />
        <mock-response status-code="200" content-type="application/json" />
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

