locals {
  network_config = { for idx, loc in var.locations : loc => {
    location = loc
    resource_group_name = var.rg_names[idx]
  } }
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = local.network_config
  name                = "${var.vnet_name}_${replace(each.key, " ", "_")}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = [var.address_space]
}

resource "azurerm_subnet" "subnet" {
  for_each             = local.network_config
  name                 = "${var.subnet_name}_${replace(each.key, " ", "_")}"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = local.network_config
  name                = "${var.nsg_name}_${replace(each.key, " ", "_")}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_security_rule" "rule" {
  for_each = local.network_config

  name                        = "AllowSSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = each.value.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

resource "azurerm_network_interface" "nic" {
  for_each            = local.network_config
  name                = "${var.nic_name}_${replace(each.key, " ", "_")}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
