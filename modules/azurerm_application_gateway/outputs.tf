output "application_gateways" {
  description = "Map of created Application Gateway resources"
  value       = azurerm_application_gateway.appgw
}

output "waf_policies" {
  description = "Map of created Web Application Firewall Policies"
  value       = azurerm_web_application_firewall_policy.waf_policy
}
