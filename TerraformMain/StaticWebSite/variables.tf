# Resource group variables
variable "rg_name" {
    description = "The name of the resource group."
    type        = string
    default = "mm-rg"
  
}
variable "rg_location" {
    description = "The location of the resource group."
    type        = string
    default = "West Europe"
  
}

# Storage account variables
variable "sa_name" {
    description = "The name of the storage account."
    type        = string
    default = "mm-sa"
  
}
variable "sa_tier" {
    description = "The Tier to use for this Storage Account. Valid options are Standard and Premium."
    type        = string
    default = "Standard"
  
}
variable "sa_replication_type" {
    description = "The Replication Type to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RA_GZRS."
    type        = string
    default = "LRS"
  
}
variable "index_document" {
    description = "The name of the index document."
    type        = string
    default = "index.html"
  
}

# Index.html file variables
variable "source_content" {
    description = "The source content for the index.html file."
    type        = string
    default = "<h1>Made with Terraform</h1><p>Hello, World!!</p>"
  
}