# terraform-alicloud-vpn-gateway
Terraform module which creates VPN resources on Alibaba Cloud.

These types of resources are supported:

* [VPN Gateway](https://www.terraform.io/docs/providers/alicloud/d/vpn_gateways.html)
* [VPN Customer Gateway](https://www.terraform.io/docs/providers/alicloud/d/vpn_customer_gateways.html)
* [VPN Connection](https://www.terraform.io/docs/providers/alicloud/d/vpn_connections.html)
* [SSL-VPN Server](https://www.terraform.io/docs/providers/alicloud/d/ssl_vpn_servers.html)
* [SSL-VPN Client Certificate](https://www.terraform.io/docs/providers/alicloud/d/ssl_vpn_client_certs.html)

##### Notes:

- If cgw is not specified, the module will launch a new one using its own parameters.
- The number of SSL-VPN client certs depends on the length of the parameter `ssl_client_cert_names`.
- If neither `cgw_id` nor `cgw_ip_address` is set, then customer gateway will not be created.
- If neither `ssl_client_ip_pool` nor `ssl_local_subnet` is set, then SSL-VPN server will not be created, even though `vpn_enable_ssl` is true.

## Usage

You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

   ```
  	module "vpn" {
		source = "terraform-alicloud-modules/vpn-gateway/alicloud"

		vpn_name = "vpn-instance-name"
		vpc_id = "vpc-xxxxx"
		vpn_bandwidth = "10"
		vpn_enable_ssl = true
		vpn_enable_ipsec = true
		vpn_charge_type = "PostPaid"
		vpn_description = "xxxxx"
		vpn_ssl_connections = 5
		cgw_ip_address = "21.37.166.152"
		cgw_name = "cgw-instance-name"
		cgw_description = "xxxxxx"
		ssl_vpn_server_name = "vss-instance-name"
		ssl_client_ip_pool = "192.168.10.0/24"
		ssl_local_subnet = "172.16.1.0/24"
		ssl_protocol = "UDP"
		ssl_cipher = "AES-128-CBC"
		ssl_port = 1194
		ssl_compress = false
		ssl_client_cert_names = ["vsc-instance-name1", "vsc-instance-name2"]
		ipsec_connection_name = "vco-instance-name"
		ipsec_local_subnet = ["192.168.1.0/24", "192.168.2.0/24"]
		ipsec_remote_subnet = ["172.16.2.0/24", "172.16.3.0/24"]
		ipsec_effect_immediately = true
		ike_auth_alg = "md5"
		ike_enc_alg = "des"
		ike_version = "ikev2"
		ike_mode = "main"
		ike_lifetime = 86400
		psk = "tf-testvpn"
		ike_pfs = "group1"
		ike_remote_id = "test-remote-id"
		ike_local_id = "test-local-id"
		ipsec_pfs = "group5"
		ipsec_enc_alg = "des"
		ipsec_auth_alg = "md5"
		ipsec_lifetime = 8640
	}
   ```

2. Setting `access_key` and `secret_key` values through environment variables:

   - ALICLOUD_ACCESS_KEY
   - ALICLOUD_SECRET_KEY
   - ALICLOUD_REGION

# Input

| Name                     | Description                                               | Type   | Default                     | Required |
| :----------------------- | :-------------------------------------------------------- | ------ | --------------------------- | -------- |
| vpn_name                     | Name of the VPN gateway.                                  | string | null                        | yes      |
| vpc_id              | The VPN belongs the vpc_id, the field can't be changed.                      | string | null                        | yes       |
| vpn_bandwidth             | The value should be 10, 100, 200, 500, 1000 if the user is postpaid, otherwise it can be 5, 10, 20, 50, 100, 200, 500, 1000.                         | int    | null                           | yes       |
| vpn_enable_ssl              | Enable or Disable SSL VPN.  At least one type of VPN should be enabled.                     | boolean | false                        | no       |
| vpn_enable_ipsec        | Enable or Disable IPSec VPN. At least one type of VPN should be enabled.                             | boolean | true                        | no      |
| vpn_charge_type | The charge type for instance. Valid value: PostPaid, PrePaid.                      | string | PostPaid                        | yes      |
| vpn_description          | The description of the VPN instance. | string| null                       | no       |
| vpn_period           | The filed is only required while the InstanceChargeType is prepaid.               | int | 1                        | yes      |
| vpn_ssl_connections               | The max connections of SSL VPN. This field is ignored when enable_ssl is false. | int | 5                        | no      |
| cgw_id      | The customer gateway id used to connect with vpn gateway.            | string| null                       | no       |
| cgw_ip_address      | The IP address of the customer gateway.            | string| null                       | no       |
| cgw_name      | The name of the VPN customer gateway.            | string| null                       | no       |
| cgw_description      | The description of the VPN customer gateway instance.            | string| null                       | no       |
| ssl_vpn_server_name      | The name of the SSL-VPN server.            | string| null                       | no       |
| ssl_client_ip_pool      | The CIDR block from which access addresses are allocated to the virtual network interface card of the client.            | string | null                       | no       |
| ssl_local_subnet      | The CIDR block to be accessed by the client through the SSL-VPN connection.            | string | null                       | no       |
| ssl_protocol      | The protocol used by the SSL-VPN server. Valid value: UDP,TCP.            | string| UDP                       | no       |
| ssl_cipher      | The encryption algorithm used by the SSL-VPN server. Valid value: AES-128-CBC, AES-192-CBC, AES-256-CBC, none.            | string| AES-128-CBC                       | no       |
| ssl_port      | The port used by the SSL-VPN server. The default value is 1194.The following ports cannot be used: [22, 2222, 22222, 9000, 9001, 9002, 7505, 80, 443, 53, 68, 123, 4510, 4560, 500, 4500].            | int | 1194                       | no       |
| ssl_compress      | Specify whether to compress the communication. Valid value: true, false.            | boolean| true                       | no       |
| ssl_client_cert_names      | The names of the client certificates.            | list | []                       | no       |
| ipsec_connection_name      | The name of the IPsec connection.            | string| null                       | no       |
| ipsec_local_subnet      | The CIDR block of the VPC to be connected with the local data center. This parameter is used for phase-two negotiation.            | list | null                       | yes       |
| ipsec_remote_subnet      | The CIDR block of the local data center. This parameter is used for phase-two negotiation.           | list | null                       | yes       |
| ipsec_effect_immediately      | Whether to delete a successfully negotiated IPsec tunnel and initiate a negotiation again. Valid value:true,false.           | boolean| true                       | no       |
| ike_auth_alg      | The authentication algorithm of phase-one negotiation. Valid value: md5, sha1.            | string| sha1                       | no       |
| ike_enc_alg      | The encryption algorithm of phase-one negotiation. Valid value: aes, aes192, aes256, des, 3des.            | string | aes                       | no       |
| ike_version      | The version of the IKE protocol. Valid value: ikev1, ikev2.            | string | ikev1                       | no       |
| ike_mode      | The negotiation mode of IKE V1. Valid value: main (main mode), aggressive (aggressive mode).           | string | main                       | no       |
| ike_lifetime      | The SA lifecycle as the result of phase-one negotiation. The valid value of n is [0, 86400], the unit is second.            | int | 86400                       | no       |
| psk      | Used for authentication between the IPsec VPN gateway and the customer gateway.            | string | null                       | no       |
| ike_pfs      | The Diffie-Hellman key exchange algorithm used by phase-one negotiation. Valid value: group1, group2, group5, group14, group24.            | string| group2                       | no       |
| ike_remote_id      | The identification of the customer gateway.            | string| null                       | no       |
| ike_local_id      | The identification of the VPN gateway.            | string| null                       | no       |
| ipsec_pfs      | The Diffie-Hellman key exchange algorithm used by phase-two negotiation. Valid value: group1, group2, group5, group14, group24.            | string| group2                       | no       |
| ipsec_enc_alg      | The encryption algorithm of phase-two negotiation. Valid value: aes, aes192, aes256, des, 3des.          | string| aes                       | no       |
| ipsec_auth_alg      | The authentication algorithm of phase-two negotiation. Valid value: md5, sha1.          | string| sha1                       | no       |
| ipsec_lifetime      | The SA lifecycle as the result of phase-two negotiation. The valid value is [0, 86400], the unit is second.            | int | 86400                       | no       |


## Output

| Name                   | Description                  |
| ---------------------- | ---------------------------- |
| vpn_id       | The ID of VPN gateway instance.       |
| cgw_id | The ID of customer gateway instance. |
| vss_id | The ID of SSL-VPN server instance.               |
| vsc_ids     | The IDs of SSL-VPN client certs. |
| vco_id     | The ID of VPN connection. |
