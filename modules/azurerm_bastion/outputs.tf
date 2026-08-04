output "bastion_hosts" {
  description = "Map of created Bastion Host resources"
  value       = azurerm_bastion_host.bastion
}
