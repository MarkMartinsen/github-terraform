resource "random_string" "sa_string" {
  length  = 6
  special = false
  upper = false
}

locals {
    workspace_suffix = terraform.workspace == "default" ? "" : "-${terraform.workspace}"

    rg_name = terraform.workspace == "default" ? "${var.rg_name}" : "${var.rg_name}-${local.workspace_suffix}"
    sa_name = terraform.workspace == "default" ? "${var.sa_name}" : "${var.sa_name}-${local.workspace_suffix}"
    website_suffix = terraform.workspace == "default" ? "${var.source_content}" :"<h1>${terraform.workspace}</h1>"
}

# Create resource group
resource "azurerm_resource_group" "rg_web" {
  name     = local.rg_name
  location = var.rg_location
}

# Create storage account
resource "azurerm_storage_account" "sa_web" {
  name                     = "${lower(local.sa_name)}${random_string.sa_string.result}"
  resource_group_name      = azurerm_resource_group.rg_web.name
  location                 = azurerm_resource_group.rg_web.location
  account_tier             = var.sa_tier
  account_replication_type = var.sa_replication_type
  static_website {
    index_document = var.index_document
  }
  tags = {
    environment = "web"
  }
  depends_on = [ azurerm_resource_group.rg_web ]
}

# Add a index.html file to the storage account
resource "azurerm_storage_blob" "index_html" {
  name                   = var.index_document
  storage_account_name   = azurerm_storage_account.sa_web.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "${var.source_content}${local.website_suffix}"
  depends_on = [ azurerm_storage_account.sa_web, azurerm_storage_container.sc_web ]
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa_web.primary_web_endpoint 
}