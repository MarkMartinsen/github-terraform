locals {
    workspace_suffix = terraform.workspace == "default" ? "" : "-${terraform.workspace}"

    rg_name = "${rg_name}-${local.workspace_suffix}"
}

resource "azurerm_resource_group" "rg" {
    name     = local.rg_name
    location = rg_location
  
}