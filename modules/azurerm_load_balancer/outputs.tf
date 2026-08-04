output "load_balancers" {
  description = "Map of created Load Balancer resources"
  value       = azurerm_lb.lb
}

output "backend_address_pools" {
  description = "Map of created Backend Address Pools"
  value       = azurerm_lb_backend_address_pool.backend_pool
}
