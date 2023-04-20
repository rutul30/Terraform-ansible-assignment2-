# Pulic Ip bloxk
resource "azurerm_public_ip" "loadbalancer-pubip" {
  count               = 2
  name                = "${var.loadbalancer-pubip}-lbpip-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.rgroup_name
  domain_name_label   = "lbdns-9198${format("%1d", count.index + 1)}"
  allocation_method   = "Static"
  tags                = var.tags
}

# Load Balancer block with frontend config
resource "azurerm_lb" "loadbalancer" {
  name                = var.loadbalancer["name"]
  location            = var.location
  resource_group_name = var.rgroup_name
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress_1"
    public_ip_address_id = azurerm_public_ip.loadbalancer-pubip[0].id
  }

  frontend_ip_configuration {
    name                 = "PublicIPAddress_2"
    public_ip_address_id = azurerm_public_ip.loadbalancer-pubip[1].id
  }
  tags                = var.tags
}

# Backend block
resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = var.backend_address_pool
}

# Backend Association Block
resource "azurerm_network_interface_backend_address_pool_association" "loadbalancer_pool_association" {
  for_each                = var.vmlinux_name
  network_interface_id    = element(var.vmlinux_network_interface_id, 0)[0][each.value]
  ip_configuration_name   = "lvm-9198-ipconfig-${each.value + 1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.id
}

#LoadBalancer Rule
resource "azurerm_lb_rule" "loadbalancer_rule" {
  count                          = 2
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "${var.loadbalancer_rule["name"]}-${format("%1d", count.index + 1)}"
  protocol                       = var.loadbalancer_rule["protocol"]
  frontend_port                  = var.loadbalancer_rule["frontend_port"]
  backend_port                   = var.loadbalancer_rule["backend_port"]
  frontend_ip_configuration_name = "PublicIPAddress_${format("%1d", count.index + 1)}"
}

#LoadBalancer Probe
resource "azurerm_lb_probe" "loadbalancer_probe" {
    loadbalancer_id                = azurerm_lb.loadbalancer.id
    name                           = var.loadbalancer_probe["name"]
    protocol                       = var.loadbalancer_probe["protocol"]
    port                           = var.loadbalancer_probe["port"]
    interval_in_seconds            = var.loadbalancer_probe["interval_in_seconds"]
    number_of_probes               = var.loadbalancer_probe["number_of_probes"]
}