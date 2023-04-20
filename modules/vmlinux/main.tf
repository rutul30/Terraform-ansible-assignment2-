# Network Interface Linux
resource "azurerm_network_interface" "linux-nic" {
  count               = var.nb_count
  name                = "${var.vmlinux_name}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.rgroup_name


  ip_configuration {
    name                          = "lvm-9198-ipconfig-${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.linux-pip[*].id, count.index + 1)
  }
}

# Linux Public IP
resource "azurerm_public_ip" "linux-pip" {
  count               = var.nb_count
  name                = "${var.vmlinux_name}-pip-${format("%1d", count.index + 1)}"
  resource_group_name = var.rgroup_name
  location            = var.location
  domain_name_label   = "${var.vmlinux_name}-dns-${format("%1d", count.index + 1)}"
  allocation_method   = "Static"

}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux-vm" {
  count               = var.nb_count
  name                = "${var.vmlinux_name}-vm-${format("%1d", count.index + 1)}"
  resource_group_name = var.rgroup_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  computer_name       = "${var.vmlinux_name}-cn-${format("%1d", count.index + 1)}"

  availability_set_id = azurerm_availability_set.linux-avs.id
  network_interface_ids = [
    element(azurerm_network_interface.linux-nic[*].id, count.index + 1)
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }
  
  os_disk {
    name                 = "${var.vmlinux_name}-os-disk-${format("%1d", count.index + 1)}"
    caching              = var.os_disk["caching"]
    storage_account_type = var.os_disk["storage_account_type"]
    disk_size_gb         = var.os_disk["disk_size"]
  }

  source_image_reference {
    publisher = var.centos_linux_os["publisher"]
    offer     = var.centos_linux_os["offer"]
    sku       = var.centos_linux_os["sku"]
    version   = var.centos_linux_os["version"]
  }

  boot_diagnostics {
    storage_account_uri = var.primary_blob_endpoint
  }

  depends_on = [azurerm_availability_set.linux-avs]
}

# Linux Availability Set 
resource "azurerm_availability_set" "linux-avs" {
  name                         = var.vmlinux_avset
  location                     = var.location
  resource_group_name          = var.rgroup_name
  platform_update_domain_count = var.vmlinux_avset_value["update_domain"]
  platform_fault_domain_count  = var.vmlinux_avset_value["fault_domain"]
}

# Network Watcher Extension
resource "azurerm_virtual_machine_extension" "linux-vme" {
  count               = var.nb_count
  name                = "${var.vmlinux_name}-vme-${format("%1d", count.index + 1)}"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux-vm[count.index].id
  publisher            = var.vme["publisher"]
  type                 = var.vme["type"]
  type_handler_version = var.vme["type_handler_version"]

  depends_on = [null_resource.ansible_provisioner]

  
}