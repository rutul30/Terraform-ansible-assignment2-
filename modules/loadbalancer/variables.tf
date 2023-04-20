variable "rgroup_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vmlinux_network_interface_id" {
    default = ""
}

variable "vmlinux_network_interface_name" {
    default = ""
}

variable "vmlinux_pip_id" {
    default = ""
}

variable "vmlinux_name" {
    default = ""
}

variable "loadbalancer-pubip" {
    default = "loadbalancer-pubip-9198"
}

variable "loadbalancer" {
    type = map(string) 
    default = {
        name    = "loadbalancer-9198"
        frontend_ip_configuration = "pubip-9198"
    }
}

variable "backend_address_pool" {
    default = "backendaddresspool-9198"
}

variable "loadbalancer_pool_association" {
    default = "loadbalancer-pool-association-9198"
}

variable "loadbalancer_rule" {
    type = map(string) 
    default = {
        name = "loadbalancer-rule-9198"
        protocol = "Tcp"
        frontend_port = 9198
        backend_port = 9198
        frontend_ip_configuration_name = "PublicIPAddress"
    }
}

variable "loadbalancer_probe" {
    type = map(string)
    default = {
        name                = "loadbalancer-probe-9198"
        protocol            = "Tcp"
        port                = 80
        interval_in_seconds = 5
        number_of_probes    = 2
    }
}