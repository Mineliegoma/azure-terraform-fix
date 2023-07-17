locals {

 network_config = { for idx, loc in var.locations : loc => {
    location = loc
    resource_group_name = var.rg_names[idx]
  } }
  network_conf = flatten([
    for loc in var.locations : [
      for i, rg_name in var.rg_names : {
        nic_name            = "${var.nic_name[i]}_${replace(loc, " ", "_")}"
        location            = loc
        resource_group_name = rg_name
        subnet_key          = "${var.nic_name[i]}_${replace(loc, " ", "_")}_${rg_name}"
      }
    ]
  ])
  
  network_conf_map = { for conf in local.network_conf : conf.subnet_key => conf }

}
resource "azurerm_virtual_network" "vnet" {
  for_each            = local.network_conf_map
  name                = "${var.vnet_name}_${replace(each.key, " ", "_")}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = [var.address_space]
}

resource "azurerm_subnet" "subnet" {
  for_each             = azurerm_virtual_network.vnet
  name                 = "${var.subnet_name}_${replace(each.key, " ", "_")}"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.name
  address_prefixes     = [var.subnet_prefix]
}
resource "azurerm_network_security_group" "nsg" {
  for_each            = local.network_config
  name                = "${replace(each.key, " ", "_")}_nsg"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  for_each            = { for nc in local.network_conf : nc.subnet_key => nc }
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet_key].id

    private_ip_address_allocation = "Dynamic"
  }
}
