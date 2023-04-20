variable "depend_on" {
    default = ""
}

variable "rgroup_name"{
    type = string
}

variable "location" {
    type = string
}
 
# variable "vmwindows_id" {
#     default = ""
# }

variable "vmlinux_id" {
    default = ""
}

# variable "vmwindows_name" {
#     default = ""
# }

variable "vmlinux_name" {
    default = ""
}

variable "storage_account_type" {
    default = "Standard_LRS"
}

variable "create_option" {
    default = "Empty"
}

variable "disk_size_gb" {
    default = 10
}

variable "lun" {
    default = 0
}

variable "data_disk_caching" {
    default = "ReadWrite"
}

variable "tags" {
  type = map(string)
}