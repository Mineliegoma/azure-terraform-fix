variable "rg_names" {
  description = "The names of the resource groups"
  type        = list(string)
}

variable "locations" {
  description = "The locations where the resource groups should be created"
  type        = list(string)
}
variable "vnet_name" {
  description = "The base name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "The base name of the subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "The address prefix of the subnet"
  type        = string
}

variable "nsg_name" {
  description = "The base name of the network security group"
  type        = string
}

variable "nic_name" {
  description = "The base name of the network interface"
  type        = list(string)
}
variable "vm_name" {
  description = "The name of the virtual machine"
  type        = list(string)
}

 variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
 
}

variable "storage_account_type" {
  description = "Defines the type of storage account to be created"
  type        = string
  default     = "Standard_LRS"
}

variable "image_publisher" {
  description = "The image publisher of the virtual machine"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "The image offer of the virtual machine"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "The image SKU of the virtual machine"
  type        = string
  default     = "16.04-LTS"
}

variable "image_version" {
  description = "The image version of the virtual machine"
  type        = string
  default     = "latest"
}

variable "os_disk_caching" {
  description = "The caching type of the OS disk"
  type        = string
  default     = "ReadWrite"
}

variable "admin_username" {
  description = "The username of the local administrator account"
  type        = string
}

variable "admin_password" {
  description = "The password of the local administrator account"
  type        = string
}

variable "enable_automatic_upgrades" {
  description = "Enable automatic OS upgrades"
  type        = bool
  default     = true
}

variable "provision_vm_agent" {
  description = "Should the Azure VM Agent be provisioned on the VM"
  type        = bool
  default     = true
}
variable "tm_name" {
  description = "The name of the Traffic Manager profile."
  type        = string
}

variable "lb_endpoints" {
  description = "Map of Load Balancer FQDNs to be used as endpoints for the Traffic Manager profile."
  type        = map(string)
}
