resource "azurerm_container_registry" "cregis" {
  name                = "azAksRegistry-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku = "Standard"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                              = var.aksname #"az-tf-aks-dev"
  location                          = var.location #azurerm_resource_group.rg.location
  resource_group_name               = var.resoucegroup #azurerm_resource_group.rg.name
  dns_prefix                        = var.aksname #"az-tf-aks-dev"
  kubernetes_version                = var.aks_version
  http_application_routing_enabled  = true
  role_based_access_control_enabled = false

  service_principal {
    client_id     = azuread_service_principal.sp.application_id
    client_secret = azuread_service_principal_password.pass.value
  }



  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  }


  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
  }

  default_node_pool {
    name                  = "default"
    node_count            = var.aks_nd_pool
    vm_size               = var.aks_vm_size
    #enable_node_public_ip = false
    enable_auto_scaling   = true
    min_count             = var.aks_min_count
    max_count             = var.aks_max_count
    type                  = var.aks_nodepool_type
    os_disk_size_gb       = var.aks_disk_size
    vnet_subnet_id        = azurerm_subnet.subnet.id
    max_pods              = var.aks_max_pods
  }
  
  tags = {
    Environment = var.tag_environment
    CreateBy    = var.tag_createBy
  }

  depends_on = [
    azurerm_log_analytics_workspace.log_analytics,
    azurerm_virtual_network.vnet,
    azurerm_subnet.subnet,
    azurerm_subnet.servicesubnet,
    azurerm_role_assignment.auth
  ]
}

resource "azurerm_role_assignment" "role_assin" {
  principal_id                     = azuread_service_principal.sp.application_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.cregis.id
  skip_service_principal_aad_check = true

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azurerm_container_registry.cregis
  ]
}