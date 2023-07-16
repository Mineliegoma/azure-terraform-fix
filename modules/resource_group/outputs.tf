output "rg_ids" {
  description = "The IDs of the resource groups"
  value       = { for idx, rg in azurerm_resource_group.rg : idx => rg.id }
}
output "rg_names" {
  description = "The names of the created resource groups"
  value       = [for r in azurerm_resource_group.rg : r.name]
}

output "locations" {
  description = "The locations of the created resource groups"
  value       = [for r in azurerm_resource_group.rg : r.location]
}

