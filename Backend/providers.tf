terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = var.rg_backend_name
    storage_account_name  = var.sa_backend_name
    container_name        = "tfstateMM"
    key                   = "mm.backend.terraform.tfstate"
    
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "4832bdd9-c568-497f-af42-3c45d1e16ef6"
  storage_use_azuread = true
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}