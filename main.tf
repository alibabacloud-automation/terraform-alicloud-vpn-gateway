// Create a new VPN gateway instance
resource "alicloud_vpn_gateway" "vpngw" {
  name                 = var.vpn_name
  vpc_id               = var.vpc_id
  bandwidth            = var.vpn_bandwidth
  enable_ssl           = var.vpn_enable_ssl
  instance_charge_type = var.vpn_charge_type
  description          = var.vpn_description
  period               = var.vpn_period
  enable_ipsec         = var.vpn_enable_ipsec
  ssl_connections      = var.vpn_ssl_connections
}

// If there is not specifying cgw_id, the module will launch a new customer gateway
resource "alicloud_vpn_customer_gateway" "vpncgw" {
  count       = var.cgw_id == "" && var.cgw_ip_address != "" ? 1 : 0
  name        = var.cgw_name
  description = var.cgw_description
  ip_address  = var.cgw_ip_address
}

// The module will launch a new SSL-VPN server if enable_ssl 
resource "alicloud_ssl_vpn_server" "sslserver" {
  count          = var.vpn_enable_ssl && var.ssl_client_ip_pool != "" && var.ssl_local_subnet != "" ? 1 : 0
  name           = var.ssl_vpn_server_name
  vpn_gateway_id = alicloud_vpn_gateway.vpngw.id
  client_ip_pool = var.ssl_client_ip_pool
  local_subnet   = var.ssl_local_subnet
  protocol       = var.ssl_protocol
  cipher         = var.ssl_cipher
  port           = var.ssl_port
  compress       = var.ssl_compress
}

// The module will launch SSL-VPN client certs if enable_ssl 
resource "alicloud_ssl_vpn_client_cert" "certs" {
  count             = var.vpn_enable_ssl && var.ssl_client_ip_pool != "" && var.ssl_local_subnet != "" ? length(var.ssl_client_cert_names) : 0
  name              = element(var.ssl_client_cert_names, count.index)
  ssl_vpn_server_id = alicloud_ssl_vpn_server.sslserver[0].id
}

// Create a new VPN connection
resource "alicloud_vpn_connection" "connection" {
  count               = var.cgw_id != "" || var.cgw_ip_address != "" ? 1 : 0
  name                = var.ipsec_connection_name
  vpn_gateway_id      = alicloud_vpn_gateway.vpngw.id
  customer_gateway_id = var.cgw_id != "" ? var.cgw_id : alicloud_vpn_customer_gateway.vpncgw[0].id
  local_subnet        = var.ipsec_local_subnet
  remote_subnet       = var.ipsec_remote_subnet
  effect_immediately  = var.ipsec_effect_immediately

  ike_config {
    ike_auth_alg  = var.ike_auth_alg
    ike_enc_alg   = var.ike_enc_alg
    ike_version   = var.ike_version
    ike_mode      = var.ike_mode
    ike_lifetime  = var.ike_lifetime
    psk           = var.psk
    ike_pfs       = var.ike_pfs
    ike_remote_id = var.ike_remote_id
    ike_local_id  = var.ike_local_id
  }

  ipsec_config {
    ipsec_pfs      = var.ipsec_pfs
    ipsec_enc_alg  = var.ipsec_enc_alg
    ipsec_auth_alg = var.ipsec_auth_alg
    ipsec_lifetime = var.ipsec_lifetime
  }
}

