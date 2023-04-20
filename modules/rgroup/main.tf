# Resource Group

resource "azurerm_resource_group" "this" {
  name     = var.rgroup_name
  location = var.location

  tags = var.tags
}
