# Resource Group
output "rgroup_name" {
  value = module.resource_group.rgroup_name
}

# Network
output "network_name" {
  value = module.network.network_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "nsg_name" {
  value = module.network.nsg_name
}

output "subnet_address_space" {
  value = module.network.subnet1_address_space
}

output "network_address_space" {
  value = module.network.network_address_space
}

output "subnet_id" {
  value = module.network.subnet1_id
}

output "nsg_id" {
  value = module.network.nsg1_id
}

# Common
output "storage_account_name" {
  value = module.common.storage_account_name
}

output "la_workspace_name" {
  value = module.common.la_workspace_name
}

output "recovery_vault_name" {
  value = module.common.recovery_vault_name
}

# Tags
output "tags" {
  value = module.resource_group.tags
}

# Linux
output "Linux_hostname" {
  value = module.linux.Linux_hostname
}
output "Linux_public_ip_addresses" {
  value = module.linux.Linux_public_ip_addresses
}
output "Linux_private_ip_address" {
  value = module.linux.Linux_private_ip_address
}
output "Linux_dns" {
  value = module.linux.Linux_dns
}

# Windows
output "Windows_hostname" {
  value = module.windows.Windows_hostname
}
output "Windows_public_ip_addresses" {
  value = module.windows.Windows_public_ip_addresses
}
output "Windows_private_ip_address" {
  value = module.windows.Windows_private_ip_address
}
output "Windows_dns" {
  value = module.windows.Windows_dns
}

# Loadbalancer
output "Loadbalancer_name" {
  value = module.loadbalancer.Loadbalancer.name
}

# Database
output "Database_instace" {
  value = module.database.Database_instace.name
}