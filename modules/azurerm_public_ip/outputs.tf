output "public_ip_ids" {
  description = "Map of public IP IDs keyed by public IP name/key"
  value       = { for k, v in azurerm_public_ip.public_ip : k => v.id }
}

output "public_ips" {
  description = "Map of public IP objects"
  value       = azurerm_public_ip.public_ip
}
