variable "rgname" {
    type = string
    description = "ressorce group name"
}

variable "location" {
    type = string
    default = "central india"
    description = "location for aks-deployemnt production"
}

variable "service_principal_name" {
    type = string
    description = "Service Principal Name"
  
}

variable "key_vault_name" {
    type = string
    description = "Key-Vault-Name"
  
}

variable "aks_cluster_name" {
    type = string
  
}






