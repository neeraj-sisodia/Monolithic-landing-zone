output "nic_ids" {
  description = "Map of network interface IDs keyed by VM key"
  value       = { for k, v in azurerm_network_interface.nic : k => v.id }
}

output "private_ip_addresses" {
  description = "Map of private IP addresses keyed by VM key"
  value       = { for k, v in azurerm_network_interface.nic : k => v.private_ip_address }
}

output "virtual_machines" {
  description = "Map of Linux virtual machine objects"
  value       = azurerm_linux_virtual_machine.virtual_machine
}
