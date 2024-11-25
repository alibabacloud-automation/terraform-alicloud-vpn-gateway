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


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ssl_vpn_client_cert.certs](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ssl_vpn_client_cert) | resource |
| [alicloud_ssl_vpn_server.sslserver](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ssl_vpn_server) | resource |
| [alicloud_vpn_connection.connection](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpn_connection) | resource |
| [alicloud_vpn_customer_gateway.vpncgw](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpn_customer_gateway) | resource |
| [alicloud_vpn_gateway.vpngw](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpn_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cgw_description"></a> [cgw\_description](#input\_cgw\_description) | The description of the VPN customer gateway instance. | `string` | `""` | no |
| <a name="input_cgw_id"></a> [cgw\_id](#input\_cgw\_id) | The customer gateway id used to connect with vpn gateway. | `string` | `null` | no |
| <a name="input_cgw_ip_address"></a> [cgw\_ip\_address](#input\_cgw\_ip\_address) | The IP address of the customer gateway. | `string` | `""` | no |
| <a name="input_cgw_name"></a> [cgw\_name](#input\_cgw\_name) | The name of the VPN customer gateway. Defaults to null. | `string` | `""` | no |
| <a name="input_create_vpn_customer_gateway"></a> [create\_vpn\_customer\_gateway](#input\_create\_vpn\_customer\_gateway) | Whether to create vpn customer gateway. | `string` | `true` | no |
| <a name="input_create_vpn_gateway"></a> [create\_vpn\_gateway](#input\_create\_vpn\_gateway) | Whether to create vpn gateway. | `string` | `true` | no |
| <a name="input_disaster_recovery_vswitch_id"></a> [disaster\_recovery\_vswitch\_id](#input\_disaster\_recovery\_vswitch\_id) | The ID of the backup VSwitch to which the VPN gateway is attached. | `string` | `null` | no |
| <a name="input_enable_tunnels_bgp"></a> [enable\_tunnels\_bgp](#input\_enable\_tunnels\_bgp) | Whether to enable BGP for the tunnels. | `bool` | `null` | no |
| <a name="input_existing_vpn_gateway_id"></a> [existing\_vpn\_gateway\_id](#input\_existing\_vpn\_gateway\_id) | The existing vpn gateway id. | `string` | `null` | no |
| <a name="input_ipsec_connection_name"></a> [ipsec\_connection\_name](#input\_ipsec\_connection\_name) | The name of the IPsec connection. | `string` | `""` | no |
| <a name="input_ipsec_effect_immediately"></a> [ipsec\_effect\_immediately](#input\_ipsec\_effect\_immediately) | Whether to delete a successfully negotiated IPsec tunnel and initiate a negotiation again. Valid value:true,false. | `bool` | `false` | no |
| <a name="input_ipsec_local_subnet"></a> [ipsec\_local\_subnet](#input\_ipsec\_local\_subnet) | The CIDR block of the VPC to be connected with the local data center. This parameter is used for phase-two negotiation. | `list(string)` | `[]` | no |
| <a name="input_ipsec_remote_subnet"></a> [ipsec\_remote\_subnet](#input\_ipsec\_remote\_subnet) | The CIDR block of the local data center. This parameter is used for phase-two negotiation. | `list(string)` | `[]` | no |
| <a name="input_ssl_cipher"></a> [ssl\_cipher](#input\_ssl\_cipher) | The encryption algorithm used by the SSL-VPN server. Valid value: AES-128-CBC (default)\| AES-192-CBC \| AES-256-CBC \| none. | `string` | `"AES-128-CBC"` | no |
| <a name="input_ssl_client_cert_names"></a> [ssl\_client\_cert\_names](#input\_ssl\_client\_cert\_names) | The names of the client certificates. | `list(string)` | `[]` | no |
| <a name="input_ssl_client_ip_pool"></a> [ssl\_client\_ip\_pool](#input\_ssl\_client\_ip\_pool) | The CIDR block from which access addresses are allocated to the virtual network interface card of the client. | `string` | `""` | no |
| <a name="input_ssl_compress"></a> [ssl\_compress](#input\_ssl\_compress) | Specify whether to compress the communication. Valid value: true (default) \| false. | `bool` | `true` | no |
| <a name="input_ssl_local_subnet"></a> [ssl\_local\_subnet](#input\_ssl\_local\_subnet) | The CIDR block to be accessed by the client through the SSL-VPN connection. | `string` | `""` | no |
| <a name="input_ssl_port"></a> [ssl\_port](#input\_ssl\_port) | The port used by the SSL-VPN server. The default value is 1194.The following ports cannot be used: [22, 2222, 22222, 9000, 9001, 9002, 7505, 80, 443, 53, 68, 123, 4510, 4560, 500, 4500]. | `number` | `1194` | no |
| <a name="input_ssl_protocol"></a> [ssl\_protocol](#input\_ssl\_protocol) | The protocol used by the SSL-VPN server. Valid value: UDP(default) \|TCP. | `string` | `"UDP"` | no |
| <a name="input_ssl_vpn_server_name"></a> [ssl\_vpn\_server\_name](#input\_ssl\_vpn\_server\_name) | The name of the SSL-VPN server. | `string` | `""` | no |
| <a name="input_tunnel_options_specification"></a> [tunnel\_options\_specification](#input\_tunnel\_options\_specification) | The tunnel options specification config. | <pre>list(object({<br>    role                 = optional(string, null)<br>    status               = optional(string, null)<br>    customer_gateway_id  = optional(string, null)<br>    enable_nat_traversal = optional(bool, null)<br>    enable_dpd           = optional(bool, null)<br>    tunnel_ike_config = optional(list(object({<br>      ike_auth_alg = optional(string, null)<br>      local_id     = optional(string, null)<br>      ike_enc_alg  = optional(string, null)<br>      ike_version  = optional(string, null)<br>      ike_mode     = optional(string, null)<br>      ike_lifetime = optional(string, null)<br>      psk          = optional(string, null)<br>      remote_id    = optional(string, null)<br>      ike_pfs      = optional(string, null)<br>    })), [])<br>    tunnel_bgp_config = optional(list(object({<br>      local_asn    = optional(string, null)<br>      tunnel_cidr  = optional(string, null)<br>      local_bgp_ip = optional(string, null)<br>    })), [])<br>    tunnel_ipsec_config = optional(list(object({<br>      ipsec_pfs      = optional(string, null)<br>      ipsec_enc_alg  = optional(string, null)<br>      ipsec_auth_alg = optional(string, null)<br>      ipsec_lifetime = optional(number, null)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPN belongs the vpc\_id, the field can't be changed. | `string` | `""` | no |
| <a name="input_vpn_bandwidth"></a> [vpn\_bandwidth](#input\_vpn\_bandwidth) | The value should be 10, 100, 200, 500, 1000 if the user is postpaid, otherwise it can be 5, 10, 20, 50, 100, 200, 500, 1000. | `number` | `10` | no |
| <a name="input_vpn_charge_type"></a> [vpn\_charge\_type](#input\_vpn\_charge\_type) | The charge type for instance. Valid value: PostPaid, PrePaid. Default to PostPaid. | `string` | `"PostPaid"` | no |
| <a name="input_vpn_description"></a> [vpn\_description](#input\_vpn\_description) | The description of the VPN instance. | `string` | `""` | no |
| <a name="input_vpn_enable_ipsec"></a> [vpn\_enable\_ipsec](#input\_vpn\_enable\_ipsec) | Enable or Disable IPSec VPN. At least one type of VPN should be enabled. | `bool` | `true` | no |
| <a name="input_vpn_enable_ssl"></a> [vpn\_enable\_ssl](#input\_vpn\_enable\_ssl) | Enable or Disable SSL VPN.  At least one type of VPN should be enabled. | `bool` | `false` | no |
| <a name="input_vpn_name"></a> [vpn\_name](#input\_vpn\_name) | Name of the VPN gateway. | `string` | `""` | no |
| <a name="input_vpn_period"></a> [vpn\_period](#input\_vpn\_period) | The filed is only required while the InstanceChargeType is prepaid. | `number` | `1` | no |
| <a name="input_vpn_ssl_connections"></a> [vpn\_ssl\_connections](#input\_vpn\_ssl\_connections) | The max connections of SSL VPN. Default to 5. This field is ignored when enable\_ssl is false. | `number` | `5` | no |
| <a name="input_vswitch_id"></a> [vswitch\_id](#input\_vswitch\_id) | The ID of the VSwitch to which the VPN gateway is attached. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_ssl_vpn_client_cert_ids"></a> [this\_ssl\_vpn\_client\_cert\_ids](#output\_this\_ssl\_vpn\_client\_cert\_ids) | The IDs of SSL-VPN client certs. |
| <a name="output_this_ssl_vpn_server_id"></a> [this\_ssl\_vpn\_server\_id](#output\_this\_ssl\_vpn\_server\_id) | The ID of SSL-VPN server instance. |
| <a name="output_this_vpn_connection_id"></a> [this\_vpn\_connection\_id](#output\_this\_vpn\_connection\_id) | The ID of VPN connection. |
| <a name="output_this_vpn_customer_gateway_id"></a> [this\_vpn\_customer\_gateway\_id](#output\_this\_vpn\_customer\_gateway\_id) | The ID of customer gateway instance. |
| <a name="output_this_vpn_gateway_id"></a> [this\_vpn\_gateway\_id](#output\_this\_vpn\_gateway\_id) | The ID of VPN gateway instance. |
<!-- END_TF_DOCS -->

## Notes
From the version v1.2.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
   version              = ">=1.56.0"
   region               = var.region != "" ? var.region : null
   configuration_source = "terraform-alicloud-modules/vpn-gateway"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.1.0:

```hcl
module "vpn" {
   source   = "terraform-alicloud-modules/vpn-gateway/alicloud"
   version  = "1.1.0"
   region   = "cn-beijing"
   vpn_name = "vpn-instance-name"
   vpc_id   = "vpc-xxxxx"
   // ...
}
```

If you want to upgrade the module to 1.2.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region = "cn-beijing"
}
module "vpn" {
   source   = "terraform-alicloud-modules/vpn-gateway/alicloud"
   vpn_name = "vpn-instance-name"
   vpc_id   = "vpc-xxxxx"
   // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
   region = "cn-beijing"
   alias  = "bj"
}
module "vpn" {
   source    = "terraform-alicloud-modules/vpn-gateway/alicloud"
   providers = {
      alicloud = alicloud.bj
   }
   vpn_name  = "vpn-instance-name"
   vpc_id    = "vpc-xxxxx"
   // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)


Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.
Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)