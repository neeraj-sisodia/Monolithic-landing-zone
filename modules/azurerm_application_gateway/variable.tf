variable "app_gateway" {
  type        = any
  description = "Map of Application Gateway configurations"
}

variable "frontend_vms" {
  type        = any
  description = "Map of Frontend VM configurations for backend pool lookup"
  default     = {}
}
