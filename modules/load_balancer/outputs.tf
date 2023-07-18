/* output "lb_ids" {
  description = "The IDs of the load balancers"
  value       = { for key, lb in azurerm_lb.lb : key => lb.id }
}

output "bap_ids" {
  description = "The IDs of the backend address pools"
  value       = { for key, bap in azurerm_lb_backend_address_pool.bap : key => bap.id }
} */

output "lb_fqdns" {
  description = "The FQDN of the load balancers."
  value = { for ip in azurerm_public_ip.lb : ip.location => ip.fqdn }
}



