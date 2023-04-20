# Vnet Block
resource "azurerm_virtual_network" "network" {
  name                = var.vnet_name
  address_space       = [var.vnet_space]
  location            = var.location
  resource_group_name = var.rgroup_name

  tags = var.tags
}

# Subnet Block
resource "azurerm_subnet" "subnet-1" {
  name                 = var.subnet_name
  resource_group_name  = var.rgroup_name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = [var.subnet_space]

}

# Security Group Block
resource "azurerm_network_security_group" "nsg-1" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rgroup_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}
