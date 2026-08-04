resource "azurerm_web_application_firewall_policy" "waf_policy" {
  for_each            = var.app_gateway
  name                = lookup(each.value, "waf_policy_name", "${each.value.name}-wafpolicy")
  resource_group_name = each.value.rg_name
  location            = each.value.location

  policy_settings {
    enabled = true
    mode    = lookup(each.value, "waf_mode", "Prevention")
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

resource "azurerm_application_gateway" "appgw" {
  for_each            = var.app_gateway
  name                = each.value.name
  resource_group_name = each.value.rg_name
  location            = each.value.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = lookup(each.value, "capacity", 2)
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = data.azurerm_subnet.appgw_subnet[each.key].id
  }

  frontend_port {
    name = "frontend-port-80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = data.azurerm_public_ip.appgw_pip[each.key].id
  }

  backend_address_pool {
    name         = "frontend-backend-pool"
    ip_addresses = [for nic_key, nic in data.azurerm_network_interface.frontend_nic : nic.private_ip_address]
  }

  backend_http_settings {
    name                  = "http-setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "frontend-port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "frontend-backend-pool"
    backend_http_settings_name = "http-setting"
    priority                   = 1
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.waf_policy[each.key].id
}
