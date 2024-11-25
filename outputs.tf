output "this_vpn_gateway_id" {
  description = "The ID of VPN gateway instance."
  value       = local.vpn_gateway_id
}

output "this_vpn_customer_gateway_id" {
  description = "The ID of customer gateway instance."
  value       = alicloud_vpn_customer_gateway.vpncgw[*].id
}

output "this_ssl_vpn_server_id" {
  description = "The ID of SSL-VPN server instance."
  value       = alicloud_ssl_vpn_server.sslserver[*].id
}

output "this_ssl_vpn_client_cert_ids" {
  description = "The IDs of SSL-VPN client certs."
  value       = alicloud_ssl_vpn_client_cert.certs[*].id
}

output "this_vpn_connection_id" {
  description = "The ID of VPN connection."
  value       = alicloud_vpn_connection.connection[*].id
}
