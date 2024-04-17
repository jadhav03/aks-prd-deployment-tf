provider "azurerm" {
   features {
     
   }

}

resource "azurerm_resource_group" "aks-prd" {
    name = var.rgname
    location = var.location
  
}

module "ServicePrincipal" {
    source = "./modules/ServicePrincipal"
    service_principal_name = var.service_principal_name 

    depends_on = [ 
        azurerm_resource_group.aks-prd
     ]  
}

resource "azurerm_role_assignment" "rolespn" {
    scope = "/subscriptions/93fa86aa-e126-4eb9-9c4c-14b36db4bb47"
    role_definition_name = "contributor"
    principal_id = module.ServicePrincipal.service_principal_object_id
    depends_on = [ module.ServicePrincipal ]
  
}

module "keyvault" {
    source = "./modules/keyvault"
    key_vault_name = var.key_vault_name
    location = var.location
    resource_group_name = var.rgname
    service_principal_name = var.service_principal_name
    service_principal_object_id = module.ServicePrincipal.service_principal_object_id
    service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id
}

resource "azurerm_key_vault_secret" "kv-aks" {
  name         = module.ServicePrincipal.client_id
  value        = module.ServicePrincipal.client_secret
  key_vault_id = module.keyvault.key_vault_id
}

module "aks-cluster" {
    source = "./modules/aks-cluster"
    aks_cluster_name = var.aks_cluster_name
    location = var.location
    resource_group_name = var.rgname
    service_principal_name = var.service_principal_name
    client_id = module.service_principal.client_id
    client_secret = module.service_principal.client_secret

    depends_on = [ module.ServicePrincipal ]

}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.config
  
}