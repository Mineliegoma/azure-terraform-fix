variable "rg_names" {
  description = "The name of the resource group in which to create the load balancer"
  type        = list(string)
}

variable "locations" {
  description = "The locations where the load balancers will be created"
  type        = list(string)
}
