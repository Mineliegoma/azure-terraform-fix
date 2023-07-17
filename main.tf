module "resource_group" {
  source = "./modules/resource_group"

  rg_names = var.rg_names
  locations = var.locations
}
module "network" {
  source = "./modules/network"
 

  rg_names       = var.rg_names
  locations      = var.locations
  vnet_name      = var.vnet_name
  address_space  = var.address_space
  subnet_name    = var.subnet_name
  subnet_prefix  = var.subnet_prefix
  nsg_name       = var.nsg_name
  nic_name       = var.nic_name
}

