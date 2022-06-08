data "azuread_client_config" "current" {}

data "azuread_domains" "example" {
  only_initial = true
}

resource "azuread_application" "app" {

  display_name     = "${var.prefix}-servicePrincipal"
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "sp" {
  application_id               = azuread_application.app.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
  depends_on = [
    azuread_application.app
  ]
}
resource "azuread_service_principal_password" "pass" {

  service_principal_id = azuread_service_principal.sp.object_id
  depends_on = [
    azuread_service_principal.sp
  ]
}
resource "azurerm_role_assignment" "auth" {
  scope                = azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.sp.id

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_subnet.subnet,
    azurerm_subnet.servicesubnet
  ]
}