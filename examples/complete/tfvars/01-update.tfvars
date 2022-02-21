#alicloud_vpn_gateway
vpn_name        = "update-tf-testacc-vpn"
vpn_description = "update-tf-testacc-description"
vpn_period      = 1

#alicloud_vpn_customer_gateway
cgw_name        = "update-tf-testacc-cgw"
cgw_description = "update-tf-testacc-cgw-description"

#alicloud_ssl_vpn_server
ssl_vpn_server_name = "update-tf-testacc-ssl"
ssl_local_subnet    = "172.16.1.0/24"
ssl_protocol        = "TCP"
ssl_cipher          = "AES-192-CBC"
ssl_compress        = false

#alicloud_ssl_vpn_client_cert
ssl_client_cert_names = ["update-tf-testacc-ssl-client-cert"]

#alicloud_vpn_connection
ipsec_connection_name    = "update-tf-testacc-ipsec"
ipsec_remote_subnet      = ["172.16.1.0/24"]
ipsec_effect_immediately = true
ike_auth_al              = "md5"
ike_enc_alg              = "aes192"
ike_version              = "ikev2"
ike_mode                 = "aggressive"
ike_lifetime             = 100
psk                      = "update-tf-testvpn"
ike_pfs                  = "group1"
ike_remote_id            = "update-test-remote-id"
ike_local_id             = "update-test-local-id"
ipsec_pfs                = "group1"
ipsec_enc_alg            = "aes192"
ipsec_auth_alg           = "md5"
ipsec_lifetime           = 100