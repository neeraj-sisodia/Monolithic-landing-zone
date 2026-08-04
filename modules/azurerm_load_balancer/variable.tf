variable "load_balancer" {
  type        = any
  description = "Map of Load Balancer configurations"
}

variable "backend_vms" {
  type        = any
  description = "Map of Backend VM configurations for backend pool association"
  default     = {}
}
