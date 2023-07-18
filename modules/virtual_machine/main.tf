/* locals {
  double_network_interface_ids = merge(
    {for k, v in var.network_interface_ids : "first_${k}" => v},
    {for k, v in var.network_interface_ids : "second_${k}" => v}
  )
} */


resource "azurerm_virtual_machine" "vm" {
   for_each = var.network_interface_ids

  name                  = "vm_${replace(each.key, " ", "_")}"
  location = join(" ", slice(split("_", element(split("/", each.value), 8)), length(split("_", element(split("/", each.value), 8))) - 2, length(split("_", element(split("/", each.value), 8)))))

  resource_group_name = split("/", each.value)[4]
  vm_size               = var.vm_size
  network_interface_ids  = [each.value]
  #network_interface_ids  = [azurerm_network_interface.nic[each.key].id]
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
  name              = "${replace(element(split("/", each.value), 8), "_", "-")}-disk-${uuid()}"
  caching           = var.os_disk_caching
  create_option     = "FromImage"
  managed_disk_type = var.storage_account_type
}


  os_profile {
    computer_name  = "osProfileLinuxConfig"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
    
  }

  tags = {
    environment = "Terraform VM"
  }
  lifecycle {
    ignore_changes = [
      storage_os_disk[0].name
    ]
  }
}
