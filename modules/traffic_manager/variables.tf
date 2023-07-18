variable "tm_name" {
  description = "The name of the Traffic Manager profile."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Traffic Manager profile."
  type        = string
}

variable "lb_endpoints" {
  description = "Map of Load Balancer FQDNs to be used as endpoints for the Traffic Manager profile."
  type        = map(string)
}
