resource "azurerm_resource_group" "rg" {
  name     =  var.resoucegroup #"az-tf-aks-environment"
  location =  var.location #"Brazil South"
}