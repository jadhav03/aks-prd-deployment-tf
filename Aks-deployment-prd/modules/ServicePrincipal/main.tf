data "azuread_client_config" "current" {}

resource "azuread_application" "aks-application" {
      display_name = var.service_principal_name
      owners = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "aks-spn" {
      client_id = azuread_application.aks-application.client_id
      app_role_assignment_required = true
      owners = [data.azuread_client_config.current.object_id]
  
}

resource "azuread_service_principal_password" "aks-spn-pass" {
  service_principal_id = azuread_service_principal.aks-spn.object_id
}

