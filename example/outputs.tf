output "vpn_id" {
  value = "${module.vpn.this_vpn_gateway_id}"
}

output "cgw_id" {
  value = "${module.vpn.this_vpn_customer_gateway_id}"
}

output "vss_id" {
  value = "${module.vpn.this_ssl_vpn_server_id}"
}

output "vsc_ids" {
  value = "${module.vpn.this_ssl_vpn_client_cert_ids}"
}

output "vco_id" {
  value = "${module.vpn.this_vpn_connection_id}"
}
