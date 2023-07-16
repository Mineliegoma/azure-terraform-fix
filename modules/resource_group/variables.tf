variable "rg_names" {
  description = "The names of the resource groups"
  type        = list(string)
}

variable "locations" {
  description = "The locations where the resource groups should be created"
  type        = list(string)
}
