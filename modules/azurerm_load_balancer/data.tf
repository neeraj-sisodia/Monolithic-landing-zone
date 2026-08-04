data "azurerm_subnet" "lb_subnet" {
  for_each             = var.load_balancer
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_network_interface" "backend_nic" {
  for_each            = var.backend_vms
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}
