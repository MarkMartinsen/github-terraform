resource "azurerm_resource_group" "rg_backend" {
    name     = var.rg_backend_name
    location = var.rg_backend_location
}

resource "random_string" "random_string" {
    length  = 7
    special = false
    upper = false
  
}
resource "azurerm_storage_account" "sa_backend" {
    name                     = "${lower(var.sa_backend_name)}${random_string.random_string.result}"
    resource_group_name      = azurerm_resource_group.rg_backend.name
    location                 = azurerm_resource_group.rg_backend.location
    account_tier             = var.sa_backend_tier
    account_replication_type = var.sa_backend_replication_type
    tags = {
        environment = "backend"
    }
    depends_on = [ azurerm_resource_group.rg_backend ]
}

resource "azurerm_storage_container" "sc_backend" {
    name                  = var.sc_backend_name
    storage_account_name  = azurerm_storage_account.sa_backend.name
    container_access_type = var.sc_container_access_type
    depends_on = [ azurerm_storage_account.sa_backend]
}

resource "random_string" "random_string1" {
    length  = 7
    special = false
    upper = false
  
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_backend" {
  name = "${lower(var.kv_backend_name)}${random_string.random_string1.result}"
  location = var.rg_backend_location
  resource_group_name = var.rg_backend.name
  enabled_for_disk_encryption = true
  tenant_id = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create",
    ]

    secret_permissions = [
      "Get", "List", "Set","Delete",
    ]

    storage_permissions = [
      "Get", "List", "Delete", "Set", "Update",
    ]
  }
  depends_on = [ var.rg_backend ]
}

resource "azurerm_key_vault_secret" "kv_backend_accesskey" {
  name         = var.kv_backend_accesskey_name
  value        = var.primary_access_key
  key_vault_id = azurerm_key_vault.kv_backend.id
  depends_on = [ azurerm_key_vault.kv_backend ]
}