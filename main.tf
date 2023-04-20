# Resource Group Module
module "resource_group" {
  source                = "./modules/rgroup"
  rgroup_name           = "99198-assignment2-RG"
  location              = "canadacentral"
  tags                  ={
    Project             = "Automation Project – Assignment 2"
    Name                = "Rutul.Joshi"
    ExpirationDate      = "2023-06-30"
    Environment         = "Lab"
  }
}

# Network Module
module "network" {
  source                = "./modules/network"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  vnet_name             = "vnet-production"
  vnet_space            = "10.0.0.0/16"
  subnet_name           = "subnet-1"
  subnet_space          = "10.0.1.0/24"
  nsg_name              = "nsg-1"
  tags                  = module.resource_group.tags
} 

#Common Module
module "common" {
  source                = "./modules/common"
  location              = module.resource_group.location
  rgroup_name           = module.resource_group.rgroup_name
  storage_account       = "storageaccountrutul9198"
  container_name        = "tfstatefiles"
  la_workspace          = {
    law_name            = "laworkspacerutul9198"
    log_sku             = "PerGB2018"
    retention           = 30
  }
  rs_vault = {
    vault_name          = "rsvaultrutul9198"
    vault_sku           = "Standard"
  }
  tags                  = module.resource_group.tags
}

# Linux Module
module "linux" {
  source                = "./modules/vmlinux"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  vmlinux_name          = "linux-9198-vm"
  vmlinux_avset         = "linux-avs"
  size                  = "Standard_B1ms"
  nb_count              = 2
  subnet_id             = module.network.subnet1_id
  tags                  = module.resource_group.tags
  primary_blob_endpoint = module.common.primary_blob_endpoint
  admin_username        = "rj3099"
  public_key_path       = "/home/rutul/.ssh/id_rsa.pub"
  private_key_path      = "/home/rutul/.ssh/id_rsa"
  linux_fqdn            = "n01499198@humber.com"

}

# Windows Module
module "windows" {
  source                = "./modules/vmwindows"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  vmwindows_name        = "win-9198"
  vmwindows_avset       = "win-avs"
  size                  = "Standard_B1ms"
  subnet_id             = module.network.subnet1_id
  tags                  = module.resource_group.tags
  primary_blob_endpoint = module.common.primary_blob_endpoint
}

# Datadisk Module
module "datadisk" {
  source                = "./modules/datadisk"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  //vmwindows_name        = module.windows.Windows_hostname
  //vmwindows_id          = module.windows.Windows_vm.id
  tags                  = module.resource_group.tags
  vmlinux_name          = {
    lvm-9198-vm-1 = 0
    lvm-9198-vm-2 = 1
  }
  vmlinux_id            = [module.linux.Linux_id]
}

# LoadBalancer Module
module "loadbalancer" {
  source                = "./modules/loadbalancer"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  tags                  = module.resource_group.tags
  vmlinux_name          = {
    lvm-9198-vm-1 = 0
    lvm-9198-vm-2 = 1
  }
  vmlinux_network_interface_id = [module.linux.Linux_network_interface_id]
  vmlinux_pip_id               = module.linux.Linux_public_ip_addresses_id

}

# Database Module
module "database" {
  source                = "./modules/database"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  psql_server_name      = "postgresql-server-9198"
  psql_db_name          = "database-9198"
  tags                  = module.resource_group.tags
}
