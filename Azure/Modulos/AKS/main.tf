# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.20.0"
    }
  }
  #terraform init -backend-config=backend.conf
  #backend "azurerm" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "azuread" {

  tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resoucegroup
  location = var.location
}