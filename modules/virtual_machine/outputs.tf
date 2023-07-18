output "virtual_machine_ids" {
  description = "The IDs of the virtual machines"
  value       = { for vm in azurerm_virtual_machine.vm : "${vm.name}_${vm.location}" => vm.id }
}

/* output "virtual_machine_public_ips" {
  description = "The public IP addresses of the virtual machines"
  value       = { for vm in azurerm_virtual_machine.vm : "${vm.name}_${vm.location}" => vm.public_ip_address }
} */

