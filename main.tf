locals {
  vpn_gateway_id          = var.create_vpn_gateway ? alicloud_vpn_gateway.vpngw[0].id : var.existing_vpn_gateway_id
  vpn_customer_gateway_id = var.create_vpn_customer_gateway ? alicloud_vpn_customer_gateway.vpncgw[0].id : var.cgw_id
}

# Create a new VPN gateway instance
resource "alicloud_vpn_gateway" "vpngw" {
  count                        = var.create_vpn_gateway ? 1 : 0
  vpn_gateway_name             = var.vpn_name
  vpc_id                       = var.vpc_id
  vswitch_id                   = var.vswitch_id
  disaster_recovery_vswitch_id = var.disaster_recovery_vswitch_id
  bandwidth                    = var.vpn_bandwidth
  enable_ssl                   = var.vpn_enable_ssl
  enable_ipsec                 = var.vpn_enable_ipsec
  payment_type                 = var.vpn_charge_type
  description                  = var.vpn_description
  period                       = var.vpn_period
  ssl_connections              = var.vpn_ssl_connections
}

# If there is not specifying cgw_id, the module will launch a new customer gateway
resource "alicloud_vpn_customer_gateway" "vpncgw" {
  count                 = var.create_vpn_customer_gateway ? 1 : 0
  customer_gateway_name = var.cgw_name
  ip_address            = var.cgw_ip_address
  description           = var.cgw_description
}

# The module will launch a new SSL-VPN server if enable_ssl 
resource "alicloud_ssl_vpn_server" "sslserver" {
  count          = var.vpn_enable_ssl && var.ssl_local_subnet != "" ? 1 : 0
  name           = var.ssl_vpn_server_name
  vpn_gateway_id = local.vpn_gateway_id
  client_ip_pool = var.ssl_client_ip_pool
  local_subnet   = var.ssl_local_subnet
  protocol       = var.ssl_protocol
  cipher         = var.ssl_cipher
  port           = var.ssl_port
  compress       = var.ssl_compress
}

# The module will launch SSL-VPN client certs if enable_ssl 
resource "alicloud_ssl_vpn_client_cert" "certs" {
  count             = var.vpn_enable_ssl && var.ssl_local_subnet != "" ? length(var.ssl_client_cert_names) : 0
  name              = element(var.ssl_client_cert_names, count.index)
  ssl_vpn_server_id = alicloud_ssl_vpn_server.sslserver[0].id
}

# Create a new VPN connection
resource "alicloud_vpn_connection" "connection" {
  count               = var.cgw_ip_address != "" ? 1 : 0
  vpn_connection_name = var.ipsec_connection_name
  vpn_gateway_id      = local.vpn_gateway_id
  local_subnet        = var.ipsec_local_subnet
  remote_subnet       = var.ipsec_remote_subnet
  effect_immediately  = var.ipsec_effect_immediately
  enable_tunnels_bgp  = var.enable_tunnels_bgp
  dynamic "tunnel_options_specification" {
    for_each = var.tunnel_options_specification
    content {
      role                 = tunnel_options_specification.value.role
      status               = tunnel_options_specification.value.status
      customer_gateway_id  = local.vpn_customer_gateway_id
      enable_nat_traversal = tunnel_options_specification.value.enable_nat_traversal
      enable_dpd           = tunnel_options_specification.value.enable_dpd
      dynamic "tunnel_ike_config" {
        for_each = tunnel_options_specification.value.tunnel_ike_config
        content {
          ike_auth_alg = tunnel_ike_config.value.ike_auth_alg
          local_id     = tunnel_ike_config.value.local_id
          remote_id    = tunnel_ike_config.value.remote_id
          ike_version  = tunnel_ike_config.value.ike_version
          ike_mode     = tunnel_ike_config.value.ike_mode
          ike_lifetime = tunnel_ike_config.value.ike_lifetime
          psk          = tunnel_ike_config.value.psk
          ike_pfs      = tunnel_ike_config.value.ike_pfs
          ike_enc_alg  = tunnel_ike_config.value.ike_enc_alg
        }
      }
      dynamic "tunnel_bgp_config" {
        for_each = tunnel_options_specification.value.tunnel_bgp_config
        content {
          local_asn    = tunnel_bgp_config.value.local_asn
          tunnel_cidr  = tunnel_bgp_config.value.tunnel_cidr
          local_bgp_ip = tunnel_bgp_config.value.local_bgp_ip
        }
      }


      dynamic "tunnel_ipsec_config" {
        for_each = tunnel_options_specification.value.tunnel_ipsec_config
        content {
          ipsec_pfs      = tunnel_ipsec_config.value.ipsec_pfs
          ipsec_enc_alg  = tunnel_ipsec_config.value.ipsec_enc_alg
          ipsec_auth_alg = tunnel_ipsec_config.value.ipsec_auth_alg
          ipsec_lifetime = tunnel_ipsec_config.value.ipsec_lifetime
        }
      }
    }
  }
}
