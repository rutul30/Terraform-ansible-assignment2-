#Windows Disk
# resource "azurerm_managed_disk" "windows_data_disk" {
#   name                 = "${var.vmwindows_name}-data-disk"
#   location             = var.location
#   resource_group_name  = var.rgroup_name
#   storage_account_type = var.storage_account_type
#   create_option        = var.create_option
#   disk_size_gb         = var.disk_size_gb
#   tags                 = var.tags

# }

# Windows Disk attachment
# resource "azurerm_virtual_machine_data_disk_attachment" "windows_data_disk_attach" {
#   managed_disk_id      = azurerm_managed_disk.windows_data_disk.id
#   virtual_machine_id   = var.vmwindows_id
#   lun                  = var.lun
#   caching              = var.data_disk_caching
#   depends_on = [azurerm_managed_disk.windows_data_disk]
# }

# Linux Disk
 resource "azurerm_managed_disk" "linux_data_disk" {
  for_each             = var.vmlinux_name
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.rgroup_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
  depends_on           = [var.depend_on]
}

# Linux Disk attachment
resource "azurerm_virtual_machine_data_disk_attachment" "linux_data_disk_attach" {
  for_each             = var.vmlinux_name
  managed_disk_id      = azurerm_managed_disk.linux_data_disk[each.key].id 
  virtual_machine_id   = element(var.vmlinux_id,0)[0][each.value]
  lun                  = var.lun
  caching              = var.data_disk_caching
  depends_on           = [azurerm_managed_disk.linux_data_disk]
}