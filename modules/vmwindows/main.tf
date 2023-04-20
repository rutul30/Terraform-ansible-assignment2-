# Network Interface Windows
resource "azurerm_network_interface" "windows-nic" {
  name                = "${var.vmwindows_name}-nic"
  location            = var.location
  resource_group_name = var.rgroup_name
  tags = var.tags
  
  ip_configuration {
    name                          = "${var.vmwindows_name}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.windows-pip.id
  }
}

# Windows Public Ip block
resource "azurerm_public_ip" "windows-pip" {
  name                = "${var.vmwindows_name}-pip"
  resource_group_name = var.rgroup_name
  location            = var.location
  domain_name_label   = "${var.vmwindows_name}-dns"
  allocation_method   = "Static"
  tags = var.tags 

}

# Windows Virtual Machine Block
resource "azurerm_windows_virtual_machine" "windows-vm" {
  name                = "${var.vmwindows_name}-vm"
  resource_group_name = var.rgroup_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  computer_name       = "${var.vmwindows_name}"
  availability_set_id = azurerm_availability_set.windows-avs.id
  
  tags = var.tags
  
  network_interface_ids = [
    azurerm_network_interface.windows-nic.id
  ]


  os_disk {
    name                 = "${var.vmwindows_name}-os-disk"
    caching              = var.windows_os_disk["caching"]
    storage_account_type = var.windows_os_disk["storage_account_type"]
    disk_size_gb = var.windows_os_disk["disk_size"]
  }

  source_image_reference {
    publisher = var.windows_os["publisher"]
    offer     = var.windows_os["offer"]
    sku       = var.windows_os["sku"]
    version   = var.windows_os["version"]
  }

  winrm_listener {
      protocol = "Http"
  }

  boot_diagnostics {
    storage_account_uri = var.primary_blob_endpoint
  }

  depends_on = [azurerm_availability_set.windows-avs]
  
}

# Windows Avalibility Set
resource "azurerm_availability_set" "windows-avs" {
  name                = var.vmwindows_avset
  location            = var.location
  resource_group_name = var.rgroup_name
  platform_update_domain_count = var.vmwindows_avset_values["update_domain"]
  platform_fault_domain_count = var.vmwindows_avset_values["fault_domain"]
}


# Windows AnimalWare extension
resource "azurerm_virtual_machine_extension" "windows-vmexe" {
  name                = "${var.vmwindows_name}-vmexe"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows-vm.id
  publisher            = var.windows_vmexe["publisher"]
  type                 = var.windows_vmexe["type"]
  type_handler_version = var.windows_vmexe["type_handler_version"]
  tags                = var.tags
}