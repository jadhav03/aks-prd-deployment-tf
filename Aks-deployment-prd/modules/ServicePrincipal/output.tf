output "service_principal_name" {
    description = "the object id of service principal. can be used to assigned roles"
    value = azuread_service_principal.aks-spn.display_name
}

output "service_principal_object_id" {
    description = "the object id of service principal. can be used to asign role"
    value = azuread_service_principal.aks-spn.object_id
}

output "service_principal_tenant_id" {
    value = azuread_service_principal.aks-spn.application_tenant_id
}

output "service_principal_application_id" {
    description = "the object id of service principal to assign role"
    value = azuread_service_principal.aks-spn.application_id

}

output "client_id" {
    description = "service principal client id"
    value = azuread_service_principal.aks-spn.client_id
  
}

output "client_secret" {
    description = "Service Principal Client secret"
    value = azuread_service_principal_password.aks-spn-pass.value
  
}