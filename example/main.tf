module "vpn" {
  source = "../"

  vpn_name                 = "vpn-instance-name"
  vpc_id                   = "vpc-xxxxx"
  vpn_bandwidth            = "10"
  vpn_enable_ssl           = true
  vpn_enable_ipsec         = true
  vpn_charge_type          = "PostPaid"
  vpn_description          = "xxxxx"
  vpn_ssl_connections      = 5
  cgw_ip_address           = "21.37.166.152"
  cgw_name                 = "cgw-instance-name"
  cgw_description          = "xxxxxx"
  ssl_vpn_server_name      = "vss-instance-name"
  ssl_client_ip_pool       = "192.168.10.0/24"
  ssl_local_subnet         = "172.16.1.0/24"
  ssl_protocol             = "UDP"
  ssl_cipher               = "AES-128-CBC"
  ssl_port                 = 1194
  ssl_compress             = false
  ssl_client_cert_names    = ["vsc-instance-name1", "vsc-instance-name2"]
  ipsec_connection_name    = "vco-instance-name"
  ipsec_local_subnet       = ["192.168.1.0/24", "192.168.2.0/24"]
  ipsec_remote_subnet      = ["172.16.2.0/24", "172.16.3.0/24"]
  ipsec_effect_immediately = true
  ike_auth_alg             = "md5"
  ike_enc_alg              = "des"
  ike_version              = "ikev2"
  ike_mode                 = "main"
  ike_lifetime             = 86400
  psk                      = "tf-testvpn"
  ike_pfs                  = "group1"
  ike_remote_id            = "test-remote-id"
  ike_local_id             = "test-local-id"
  ipsec_pfs                = "group5"
  ipsec_enc_alg            = "des"
  ipsec_auth_alg           = "md5"
  ipsec_lifetime           = 8640
}

