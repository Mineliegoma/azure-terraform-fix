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
module "virtual_machine" {
  source = "./modules/virtual_machine"

  vm_name                    = var.vm_name
  vm_size                    = var.vm_size
  rg_names                    = module.resource_group.rg_names
  network_interface_ids      = module.network.network_interface_ids
  locations                   = var.locations
  storage_account_type       = var.storage_account_type
  image_publisher            = var.image_publisher
  image_offer                = var.image_offer
  image_sku                  = var.image_sku
  image_version              = var.image_version
  os_disk_caching            = var.os_disk_caching
  admin_username             = var.admin_username
  admin_password             = var.admin_password
  enable_automatic_upgrades  = var.enable_automatic_upgrades
  provision_vm_agent         = var.provision_vm_agent
}
module "load_balancer" {
  source     = "./modules/load_balancer"
  rg_names   = var.rg_names
  locations  = var.locations
}
module "traffic_manager" {
  source              = "./modules/traffic_manager"
  tm_name             = var.tm_name
  resource_group_name = var.rg_names[0]
lb_endpoints    = module.load_balancer.lb_fqdns
}

