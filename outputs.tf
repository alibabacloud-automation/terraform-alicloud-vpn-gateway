output "vpn_id" {
  description = "The ID of VPN gateway instance."
  value       = "${alicloud_vpn_gateway.vpngw.id}"
}

output "cgw_id" {
  description = "The ID of customer gateway instance."
  value       = "${join(",", alicloud_vpn_customer_gateway.vpncgw.*.id)}"
}

output "vss_id" {
  description = "The ID of SSL-VPN server instance."
  value       = "${join(",", alicloud_ssl_vpn_server.sslserver.*.id)}"
}

output "vsc_ids" {
  description = "The IDs of SSL-VPN client certs."
  value       = "${join(",", alicloud_ssl_vpn_client_cert.certs.*.id)}"
}

output "vco_id" {
  description = "The ID of VPN connection."
  value       = "${join(",", alicloud_vpn_connection.connection.*.id)}"
}
