output "network_interface_ids" {
  description = "List of network interface IDs"
  value       = zipmap(keys(azurerm_network_interface.nic), values(azurerm_network_interface.nic)[*].id)
}


