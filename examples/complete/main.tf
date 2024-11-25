

data "alicloud_vpn_gateways" "default" {

}

module "vpn" {
  source = "../.."

  create_vpn_gateway      = false
  existing_vpn_gateway_id = data.alicloud_vpn_gateways.default.ids[0]

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
  tunnel_options_specification = [{
    tunnel_ipsec_config = [{
      ipsec_auth_alg = "md5"
      ipsec_enc_alg  = "aes256"
      ipsec_lifetime = "16400"
      ipsec_pfs      = "group5"
    }]


    role = "master"

    tunnel_ike_config = [{
      ike_mode     = "aggressive"
      ike_version  = "ikev2"
      local_id     = "localid_tunnel2"
      psk          = "12345678"
      remote_id    = "remote2"
      ike_auth_alg = "md5"
      ike_enc_alg  = "aes256"
      ike_lifetime = "3600"
      ike_pfs      = "group14"
    }]
    }, {
    tunnel_ike_config = [{
      remote_id    = "remote24"
      ike_enc_alg  = "aes256"
      ike_lifetime = "27000"
      ike_mode     = "aggressive"
      ike_pfs      = "group5"
      ike_auth_alg = "md5"
      ike_version  = "ikev2"
      local_id     = "localid_tunnel2"
      psk          = "12345678"
    }]

    tunnel_ipsec_config = [{
      ipsec_lifetime = "2700"
      ipsec_pfs      = "group14"
      ipsec_auth_alg = "md5"
      ipsec_enc_alg  = "aes256"
    }]


    role = "slave"

  }]
}
