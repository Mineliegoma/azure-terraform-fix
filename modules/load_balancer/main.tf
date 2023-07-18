resource "azurerm_public_ip" "lb" {
  for_each               = { for idx, loc in var.locations : loc => var.rg_names[idx] }
  name                   = "lb_publicip_${replace(each.key, " ", "_")}" 
  location               = each.key
  resource_group_name    = each.value
  allocation_method      = "Static"
  sku                    = "Standard"
  domain_name_label   = "lb-publicip-${replace(each.value, " ", "-")}" # unique DNS label

}
resource "azurerm_lb" "lb" {
  for_each               = { for idx, loc in var.locations : loc => var.rg_names[idx] }
  name                   = "lb_${replace(each.key, " ", "_")}"
  location               = each.key
  resource_group_name    = each.value
   sku                 = "Standard" 

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb[each.key].id
  }
}
