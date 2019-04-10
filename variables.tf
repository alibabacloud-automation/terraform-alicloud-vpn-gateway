variable "vpn_name" {
  description = "Name of the VPN gateway."
}

variable "vpc_id" {
  description = "The VPN belongs the vpc_id, the field can't be changed."
}

variable "vpn_bandwidth" {
  description = "The value should be 10, 100, 200, 500, 1000 if the user is postpaid, otherwise it can be 5, 10, 20, 50, 100, 200, 500, 1000."
}

variable "vpn_enable_ssl" {
  description = "Enable or Disable SSL VPN.  At least one type of VPN should be enabled."
  default     = false
}

variable "vpn_enable_ipsec" {
  description = "Enable or Disable IPSec VPN. At least one type of VPN should be enabled."
  default     = true
}

variable "vpn_charge_type" {
  description = "The charge type for instance. Valid value: PostPaid, PrePaid. Default to PostPaid."
  default     = "PostPaid"
}

variable "vpn_description" {
  description = "The description of the VPN instance."
  default     = ""
}

variable "vpn_period" {
  description = "The filed is only required while the InstanceChargeType is prepaid."
  default     = 1
}

variable "vpn_ssl_connections" {
  description = "The max connections of SSL VPN. Default to 5. This field is ignored when enable_ssl is false."
  default     = 5
}

variable "cgw_id" {
  description = "The customer gateway id used to connect with vpn gateway."
  default     = ""
}

variable "cgw_ip_address" {
  description = "The IP address of the customer gateway."
  default     = ""
}

variable "cgw_name" {
  description = "The name of the VPN customer gateway. Defaults to null."
  default     = ""
}

variable "cgw_description" {
  description = "The description of the VPN customer gateway instance."
  default     = ""
}

variable "ssl_vpn_server_name" {
  description = "The name of the SSL-VPN server."
  default     = ""
}

variable "ssl_client_ip_pool" {
  description = "The CIDR block from which access addresses are allocated to the virtual network interface card of the client."
  default     = ""
}

variable "ssl_local_subnet" {
  description = "The CIDR block to be accessed by the client through the SSL-VPN connection."
  default     = ""
}

variable "ssl_protocol" {
  description = "The protocol used by the SSL-VPN server. Valid value: UDP(default) |TCP."
  default     = "UDP"
}

variable "ssl_cipher" {
  description = "The encryption algorithm used by the SSL-VPN server. Valid value: AES-128-CBC (default)| AES-192-CBC | AES-256-CBC | none."
  default     = "AES-128-CBC"
}

variable "ssl_port" {
  description = "The port used by the SSL-VPN server. The default value is 1194.The following ports cannot be used: [22, 2222, 22222, 9000, 9001, 9002, 7505, 80, 443, 53, 68, 123, 4510, 4560, 500, 4500]."
  default     = 1194
}

variable "ssl_compress" {
  description = "Specify whether to compress the communication. Valid value: true (default) | false."
  default     = true
}

variable "ssl_client_cert_names" {
  description = "The names of the client certificates."
  type        = "list"
  default     = []
}

variable "ipsec_connection_name" {
  description = "The name of the IPsec connection."
  default     = ""
}

variable "ipsec_local_subnet" {
  description = "The CIDR block of the VPC to be connected with the local data center. This parameter is used for phase-two negotiation."
  type        = "list"
}

variable "ipsec_remote_subnet" {
  description = "The CIDR block of the local data center. This parameter is used for phase-two negotiation."
  type        = "list"
}

variable "ipsec_effect_immediately" {
  description = "Whether to delete a successfully negotiated IPsec tunnel and initiate a negotiation again. Valid value:true,false."
  default     = false
}

variable "ike_auth_alg" {
  description = "The authentication algorithm of phase-one negotiation. Valid value: md5 | sha1. Default value: sha1."
  default     = "sha1"
}

variable "ike_enc_alg" {
  description = "The encryption algorithm of phase-one negotiation. Valid value: aes | aes192 | aes256 | des | 3des. Default Valid value: aes."
  default     = "aes"
}

variable "ike_version" {
  description = "The version of the IKE protocol. Valid value: ikev1 | ikev2. Default value: ikev1."
  default     = "ikev1"
}

variable "ike_mode" {
  description = "The negotiation mode of IKE V1. Valid value: main (main mode) | aggressive (aggressive mode). Default value: main."
  default     = "main"
}

variable "ike_lifetime" {
  description = "The SA lifecycle as the result of phase-one negotiation. The valid value of n is [0, 86400], the unit is second and the default value is 86400."
  default     = 86400
}

variable "psk" {
  description = "Used for authentication between the IPsec VPN gateway and the customer gateway."
  default     = ""
}

variable "ike_pfs" {
  description = "The Diffie-Hellman key exchange algorithm used by phase-one negotiation. Valid value: group1 | group2 | group5 | group14 | group24. Default value: group2."
  default     = "group2"
}

variable "ike_remote_id" {
  description = "The identification of the customer gateway."
  default     = ""
}

variable "ike_local_id" {
  description = "The identification of the VPN gateway."
  default     = ""
}

variable "ipsec_pfs" {
  description = "The Diffie-Hellman key exchange algorithm used by phase-two negotiation. Valid value: group1 | group2 | group5 | group14 | group24. Default value: group2."
  default     = "group2"
}

variable "ipsec_enc_alg" {
  description = "The encryption algorithm of phase-two negotiation. Valid value: aes | aes192 | aes256 | des | 3des. Default value: aes."
  default     = "aes"
}

variable "ipsec_auth_alg" {
  description = "The authentication algorithm of phase-two negotiation. Valid value: md5 | sha1. Default value: sha1."
  default     = "sha1"
}

variable "ipsec_lifetime" {
  description = "The SA lifecycle as the result of phase-two negotiation. The valid value is [0, 86400], the unit is second and the default value is 86400."
  default     = 86400
}
