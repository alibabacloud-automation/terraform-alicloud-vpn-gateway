output "vpn_id" {
  value = "${module.vpn.this_vpn_id}"
}

output "cgw_id" {
  value = "${module.vpn.this_cgw_id}"
}

output "vss_id" {
  value = "${module.vpn.this_vss_id}"
}

output "vsc_ids" {
  value = "${module.vpn.this_vsc_ids}"
}

output "vco_id" {
  value = "${module.vpn.this_vco_id}"
}
