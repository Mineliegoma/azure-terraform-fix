resource "azurerm_traffic_manager_profile" "tm" {
  name                = var.tm_name
  resource_group_name = var.resource_group_name
  profile_status      = "Enabled"
  traffic_routing_method = "Performance"

  dns_config {
    relative_name = "Minelie"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_endpoint" "endpoint" {
  for_each            = var.lb_endpoints
  name                = "myTrafficManager_${each.key}"
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.tm.name
  target_resource_id  = each.value
  type                = "azureEndpoints"
  endpoint_status     = "Enabled"
  weight              = 100
  priority            = 1
  endpoint_location   = each.key
}
