output "network_name" {
  value = azurerm_virtual_network.network.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet-1.name
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg-1.name
}

output "subnet1_address_space" {
  value = azurerm_subnet.subnet-1.address_prefixes
}

output "network_address_space" {
  value = azurerm_virtual_network.network.address_space[0]
}

output "subnet1_id" {
  value = azurerm_subnet.subnet-1.id
}

output "nsg1_id" {
  value = azurerm_network_security_group.nsg-1.id
}
