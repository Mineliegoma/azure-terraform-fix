variable "rg_names" {
  description = "The names of the resource groups"
  type        = list(string)
}

variable "locations" {
  description = "The locations where the resources should be created"
  type        = list(string)
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "The address prefix of the subnet"
  type        = string
}

variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface"
  type        = list(string)
}


