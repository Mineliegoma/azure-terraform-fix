rg_names  = ["rg1", "rg2"]
locations = ["East US", "North Europe"]
vnet_name      = "my_vnet"
address_space  = "10.0.0.0/16"
subnet_name    = "my_subnet"
subnet_prefix  = "10.0.1.0/24"
nsg_name       = "my_nsg"
nic_name       = ["my_nic1","my_nic2"]
vm_size = "Standard_B1ls"
vm_name = ["vm1", "vm2", "vm3", "vm4"]
storage_account_type = "Standard_LRS"
image_publisher = "Canonical"
image_offer = "UbuntuServer"
image_sku = "16.04-LTS"
image_version = "latest"
os_disk_caching = "ReadWrite"
admin_username = "adminuser"
admin_password = "P@ssw0rd!"
enable_automatic_upgrades = true
provision_vm_agent = true
tm_name = "myTrafficManager"
lb_endpoints = {
  "East US" = "/subscriptions/1c1d1d74-5087-4883-b662-41b4bd956d32/resourceGroups/rg1/providers/Microsoft.Network/loadBalancers/lb_East_US"
  "North Europe" = "/subscriptions/1c1d1d74-5087-4883-b662-41b4bd956d32/resourceGroups/rg2/providers/Microsoft.Network/loadBalancers/lb_North_Europe"
  
}


