# StorageModule
variable "rg_backend_name" {
    description = "The name of the resource group for the backend storage account."
    type        = string
    default = "mm-rg-backend"

}

variable "rg_backend_location" {
    description = "The location of the resource group for the backend storage account."
    type        = string
    default = "West Europe"

}

variable "sa_backend_name" {
    description = "The name of the backend storage account."
    type        = string
    default = "mm-sa-backend"
  
}
variable "sa_backend_tier" {
    description = "The Tier to use for this Storage Account. Valid options are Standard and Premium."
    type        = string
    default = "Standard"
  
}
variable "sa_backend_replication_type" {
    description = "The Replication Type to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RA_GZRS."
    type        = string
    default = "LRS"
  
}
variable "sc_backend_name" {
    description = "The name of the storage container for the backend storage account."
    type        = string
    default = "mm-sc-backend"
  
}
variable "sc_container_access_type" {
    description = "The access level for the storage container. Valid options are private, blob and container."
    type        = string
    default = "private"
  
}

# KeyVaultModule
variable "kv_backend_name" {
    description = "The name of the backend key vault."
    type        = string
    default = "mm-kv-backend"
  
}
variable "kv_backend_accesskey_name" {
    description = "The name of the secret for the backend storage account access key."
    type = string
    
}
variable "primary_access_key" {
    description = "The primary access key of the backend storage account."
    type        = string
    default = "primary_access_key"
    sensitive = true
  
}
variable "rg_backend" {
    description = "resource group"
    type = object({
        name     = string
        location = string
    })
    default = {
      location = "West-Europe"
      name     = "mm-rg-backend"
    }
  
}
