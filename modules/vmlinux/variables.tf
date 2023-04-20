variable "rgroup_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vmlinux_name" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "private_key_path" {
  type = string
}

variable "linux_fqdn" {
  type = string
}

variable "os_disk" {
  type = map(string)
  default = {
    storage_account_type = "Premium_LRS"
    disk_size            = 32
    caching              = "ReadWrite"
  }
}

variable "centos_linux_os" {
  type = map(string)
  default = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}

variable "vmlinux_avset" {
  default = "linux-avs-9198"
}

variable "vmlinux_avset_value" {
  type = map(string)
  default = {
    update_domain = 10
    fault_domain  = 2
  }
}

variable "primary_blob_endpoint" {
  type        = string
}

variable "nb_count" {
  default = ""
}

variable "vme" {
  type = map(string)
  default = {
    publisher  = "Microsoft.Azure.NetworkWatcher"
    type  = "NetworkWatcherAgentLinux"
    type_handler_version ="1.4"
  }
}

variable "tags" {
  type = map(string)
}
