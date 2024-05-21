data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_name           = var.vpn_name
  vpc_cidr           = "172.16.0.0/16"
  vswitch_name       = var.vpn_name
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.example.zones.0.id]
}

module "vpn" {
  source = "../.."

  #alicloud_vpn_gateway
  vpn_name            = var.vpn_name
  vpc_id              = module.vpc.this_vpc_id
  vpn_bandwidth       = 10
  vpn_enable_ssl      = true
  vpn_enable_ipsec    = true
  vpn_charge_type     = "PrePaid"
  vpn_description     = var.vpn_description
  vpn_period          = var.vpn_period
  vpn_ssl_connections = 5

  #alicloud_vpn_customer_gateway
  cgw_name        = var.cgw_name
  cgw_ip_address  = "21.37.166.152"
  cgw_description = var.cgw_description

  #alicloud_ssl_vpn_server
  ssl_vpn_server_name = var.ssl_vpn_server_name
  ssl_client_ip_pool  = "10.0.0.0/16"
  ssl_local_subnet    = var.ssl_local_subnet
  ssl_protocol        = var.ssl_protocol
  ssl_cipher          = var.ssl_cipher
  ssl_port            = 1194
  ssl_compress        = var.ssl_compress

  #alicloud_ssl_vpn_client_cert
  ssl_client_cert_names = var.ssl_client_cert_names

  #alicloud_vpn_connection
  ipsec_connection_name    = var.ipsec_connection_name
  ipsec_local_subnet       = var.ipsec_local_subnet
  ipsec_remote_subnet      = var.ipsec_remote_subnet
  ipsec_effect_immediately = var.ipsec_effect_immediately
  ike_auth_alg             = var.ike_auth_alg
  ike_enc_alg              = var.ike_enc_alg
  ike_version              = var.ike_version
  ike_mode                 = var.ike_mode
  ike_lifetime             = var.ike_lifetime
  psk                      = var.psk
  ike_pfs                  = var.ike_pfs
  ike_remote_id            = var.ike_remote_id
  ike_local_id             = var.ike_local_id
  ipsec_pfs                = var.ipsec_pfs
  ipsec_enc_alg            = var.ipsec_enc_alg
  ipsec_auth_alg           = var.ipsec_auth_alg
  ipsec_lifetime           = var.ipsec_lifetime

}