#alicloud_vpn_gateway
variable "vpn_name" {
  description = "Name of the VPN gateway."
  type        = string
  default     = "tf-testacc-vpn"
}

variable "vpn_description" {
  description = "The description of the VPN instance."
  type        = string
  default     = "tf-testacc-description"
}

variable "vpn_period" {
  description = "The filed is only required while the InstanceChargeType is prepaid."
  type        = number
  default     = 2
}

#alicloud_vpn_customer_gateway
variable "cgw_name" {
  description = "The name of the VPN customer gateway. Defaults to null."
  type        = string
  default     = "tf-testacc-cgw"
}

variable "cgw_description" {
  description = "The description of the VPN customer gateway instance."
  type        = string
  default     = "tf-testacc-cgw-description"
}

#alicloud_ssl_vpn_server
variable "ssl_vpn_server_name" {
  description = "The name of the SSL-VPN server."
  type        = string
  default     = "tf-testacc-ssl"
}

variable "ssl_local_subnet" {
  description = "The CIDR block to be accessed by the client through the SSL-VPN connection."
  type        = string
  default     = "10.0.1.0/24"
}

variable "ssl_protocol" {
  description = "The protocol used by the SSL-VPN server. Valid value: UDP(default) |TCP."
  type        = string
  default     = "UDP"
}

variable "ssl_cipher" {
  description = "The encryption algorithm used by the SSL-VPN server. Valid value: AES-128-CBC (default)| AES-192-CBC | AES-256-CBC | none."
  type        = string
  default     = "AES-128-CBC"
}

variable "ssl_compress" {
  description = "Specify whether to compress the communication. Valid value: true (default) | false."
  type        = bool
  default     = true
}

#alicloud_ssl_vpn_client_cert
variable "ssl_client_cert_names" {
  description = "The names of the client certificates."
  type        = list(string)
  default     = ["tf-testacc-ssl-client-cert"]
}

#alicloud_vpn_connection
variable "ipsec_connection_name" {
  description = "The name of the IPsec connection."
  type        = string
  default     = "tf-testacc-ipsec"
}

variable "ipsec_local_subnet" {
  description = "The CIDR block of the local data center. This parameter is used for phase-two negotiation."
  type        = list(string)
  default     = ["172.16.0.0/24"]
}

variable "ipsec_remote_subnet" {
  description = "The CIDR block of the local data center. This parameter is used for phase-two negotiation."
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "ipsec_effect_immediately" {
  description = "Whether to delete a successfully negotiated IPsec tunnel and initiate a negotiation again. Valid value:true,false."
  type        = bool
  default     = false
}

variable "ike_auth_alg" {
  description = "The authentication algorithm of phase-one negotiation. Valid value: md5 | sha1. Default value: sha1."
  type        = string
  default     = "sha1"
}

variable "ike_enc_alg" {
  description = "The encryption algorithm of phase-one negotiation. Valid value: aes | aes192 | aes256 | des | 3des. Default Valid value: aes."
  type        = string
  default     = "aes"
}

variable "ike_version" {
  description = "The version of the IKE protocol. Valid value: ikev1 | ikev2. Default value: ikev1."
  type        = string
  default     = "ikev1"
}

variable "ike_mode" {
  description = "The negotiation mode of IKE V1. Valid value: main (main mode) | aggressive (aggressive mode). Default value: main."
  type        = string
  default     = "main"
}

variable "ike_lifetime" {
  description = "The SA lifecycle as the result of phase-one negotiation. The valid value of n is [0, 86400], the unit is second and the default value is 86400."
  type        = number
  default     = 86400
}

variable "psk" {
  description = "Used for authentication between the IPsec VPN gateway and the customer gateway."
  type        = string
  default     = "tf-testvpn"
}

variable "ike_pfs" {
  description = "The Diffie-Hellman key exchange algorithm used by phase-one negotiation. Valid value: group1 | group2 | group5 | group14 | group24. Default value: group2."
  type        = string
  default     = "group2"
}

variable "ike_remote_id" {
  description = "The identification of the customer gateway."
  type        = string
  default     = "test-remote-id"
}

variable "ike_local_id" {
  description = "The identification of the VPN gateway."
  type        = string
  default     = "test-local-id"
}

variable "ipsec_pfs" {
  description = "The Diffie-Hellman key exchange algorithm used by phase-two negotiation. Valid value: group1 | group2 | group5 | group14 | group24. Default value: group2."
  type        = string
  default     = "group2"
}

variable "ipsec_enc_alg" {
  description = "The encryption algorithm of phase-two negotiation. Valid value: aes | aes192 | aes256 | des | 3des. Default value: aes."
  type        = string
  default     = "aes"
}

variable "ipsec_auth_alg" {
  description = "The authentication algorithm of phase-two negotiation. Valid value: md5 | sha1. Default value: sha1."
  type        = string
  default     = "sha1"
}

variable "ipsec_lifetime" {
  description = "The SA lifecycle as the result of phase-two negotiation. The valid value is [0, 86400], the unit is second and the default value is 86400."
  type        = number
  default     = 86400
}