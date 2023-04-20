variable "rgroup_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_space" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_space" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
