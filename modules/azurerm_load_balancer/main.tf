resource "azurerm_lb" "lb" {
  for_each            = var.load_balancer
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  sku                 = lookup(each.value, "sku", "Standard")

  frontend_ip_configuration {
    name                          = "internal-frontend-ip"
    subnet_id                     = data.azurerm_subnet.lb_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.load_balancer
  name            = lookup(each.value, "backend_pool_name", "backend-pool")
  loadbalancer_id = azurerm_lb.lb[each.key].id
}

resource "azurerm_lb_probe" "hp" {
  for_each        = var.load_balancer
  name            = lookup(each.value, "probe_name", "backend-health-probe")
  loadbalancer_id = azurerm_lb.lb[each.key].id
  port            = lookup(each.value, "probe_port", 80)
  protocol        = lookup(each.value, "probe_protocol", "Tcp")
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.load_balancer
  name                           = lookup(each.value, "rule_name", "backend-lb-rule")
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = lookup(each.value, "frontend_port", 80)
  backend_port                   = lookup(each.value, "backend_port", 80)
  frontend_ip_configuration_name = "internal-frontend-ip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.hp[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  for_each                = var.backend_vms
  network_interface_id    = data.azurerm_network_interface.backend_nic[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[lookup(each.value, "lb_key", keys(var.load_balancer)[0])].id
}
