output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet key"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}

output "subnets" {
  description = "Map of subnet objects"
  value       = azurerm_subnet.subnet
}
