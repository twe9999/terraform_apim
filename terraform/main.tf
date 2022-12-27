terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.23.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "group_001" {
  name     = format("rg-mg-%s-001",var.env)
  location = var.location
  tags = {
    group        = var.group,
    env          = var.env,
    location     = var.location
    subscription = var.subscription_id
  }
}


# # App Insight
resource "azurerm_application_insights" "appinsights" {
  name                = format("appi-ixt-%s",var.env)
  resource_group_name = azurerm_resource_group.group_001.name
  location            = var.location
  application_type    = "web"

  tags = {
    group        = var.group,
    env          = var.env,
    location     = var.location
    subscription = var.subscription_id
  }
}

