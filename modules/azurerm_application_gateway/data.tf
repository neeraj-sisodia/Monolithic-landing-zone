data "azurerm_subnet" "appgw_subnet" {
  for_each             = var.app_gateway
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "appgw_pip" {
  for_each            = var.app_gateway
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

data "azurerm_network_interface" "frontend_nic" {
  for_each            = var.frontend_vms
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}
