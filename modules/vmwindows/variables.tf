variable "rgroup_name"{
    type = string
}

variable "location" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "vmwindows_name" {
    type = string
}

variable "size" {
    type = string
}

variable "admin_username" {
  default = "rutul"
}

variable "admin_password" {
  default = "rutul-30"
}

variable windows_os_disk {
    type = map(string)
    default = {
        create_option = "Attach"
        storage_account_type = "StandardSSD_LRS"
        disk_size = 128
        caching = "ReadWrite"
    }
}


variable windows_os {
    type = map(string)
    default = {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }
}

variable "vmwindows_avset" {
    default = "windows_avs-9198"
}

variable "vmwindows_avset_values" {
    type = map(string)
    default = {
        update_domain = 5
        fault_domain = 2
    }
}


variable "primary_blob_endpoint" {
  type        = string
}


variable "windows_vmexe" {
  type = map(string)
  default = {
    publisher  = "Microsoft.Azure.Security.AntimalwareSignature"
    type  = "AntimalwareConfiguration"
    type_handler_version ="2.58"
  }
}

variable "tags" {
  type = map(string)
}
