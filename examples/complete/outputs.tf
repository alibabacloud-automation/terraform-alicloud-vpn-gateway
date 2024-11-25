output "vpn_id" {
  description = "The ID of VPN gateway instance."
  value       = module.vpn.this_vpn_gateway_id
}

output "cgw_id" {
  description = "The ID of customer gateway instance."
  value       = module.vpn.this_vpn_customer_gateway_id
}

output "vss_id" {
  description = "The ID of SSL-VPN server instance."
  value       = module.vpn.this_ssl_vpn_server_id
}

output "vsc_ids" {
  description = "The IDs of SSL-VPN client certs."
  value       = module.vpn.this_ssl_vpn_client_cert_ids
}

output "vco_id" {
  description = "The ID of VPN connection."
  value       = module.vpn.this_vpn_connection_id
}