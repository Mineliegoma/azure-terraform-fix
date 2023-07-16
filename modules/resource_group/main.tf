resource "azurerm_resource_group" "rg" {
  for_each = { for idx, val in var.rg_names : idx => val }
  
  name     = var.rg_names[each.key]
  location = var.locations[each.key]
}
