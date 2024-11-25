
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

