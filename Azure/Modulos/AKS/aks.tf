resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname #"az-tf-aks-dev"
  location            = var.location #azurerm_resource_group.rg.location
  resource_group_name = var.resoucegroup #azurerm_resource_group.rg.name
  dns_prefix          = var.aksdnsprefix #"az-tf-aks-dev"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Desenvolvimento"
  }
}
