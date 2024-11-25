
#alicloud_vpn_gateway
variable "create_vpn_gateway" {
  description = "Whether to create vpn gateway."
  type        = string
  default     = true
}

variable "existing_vpn_gateway_id" {
  description = "The existing vpn gateway id."
  type        = string
  default     = null
}

variable "vpn_name" {
  description = "Name of the VPN gateway."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPN belongs the vpc_id, the field can't be changed."
  type        = string
  default     = ""
}

variable "vswitch_id" {
  description = "The ID of the VSwitch to which the VPN gateway is attached."
  type        = string
  default     = null
}

variable "disaster_recovery_vswitch_id" {
  description = "The ID of the backup VSwitch to which the VPN gateway is attached."
  type        = string
  default     = null
}

variable "vpn_bandwidth" {
  description = "The value should be 10, 100, 200, 500, 1000 if the user is postpaid, otherwise it can be 5, 10, 20, 50, 100, 200, 500, 1000."
  type        = number
  default     = 10
}

variable "vpn_enable_ssl" {
  description = "Enable or Disable SSL VPN.  At least one type of VPN should be enabled."
  type        = bool
  default     = false
}

variable "vpn_enable_ipsec" {
  description = "Enable or Disable IPSec VPN. At least one type of VPN should be enabled."
  type        = bool
  default     = true
}

variable "vpn_charge_type" {
  description = "The charge type for instance. Valid value: PostPaid, PrePaid. Default to PostPaid."
  type        = string
  default     = "PostPaid"
}

variable "vpn_description" {
  description = "The description of the VPN instance."
  type        = string
  default     = ""
}

variable "vpn_period" {
  description = "The filed is only required while the InstanceChargeType is prepaid."
  type        = number
  default     = 1
}

variable "vpn_ssl_connections" {
  description = "The max connections of SSL VPN. Default to 5. This field is ignored when enable_ssl is false."
  type        = number
  default     = 5
}

#alicloud_vpn_customer_gateway
variable "create_vpn_customer_gateway" {
  description = "Whether to create vpn customer gateway."
  type        = string
  default     = true
}

variable "cgw_id" {
  description = "The customer gateway id used to connect with vpn gateway."
  type        = string
  default     = null
}

variable "cgw_name" {
  description = "The name of the VPN customer gateway. Defaults to null."
  type        = string
  default     = ""
}

variable "cgw_description" {
  description = "The description of the VPN customer gateway instance."
  type        = string
  default     = ""
}

variable "cgw_ip_address" {
  description = "The IP address of the customer gateway."
  type        = string
  default     = ""
}

#alicloud_ssl_vpn_server
variable "ssl_vpn_server_name" {
  description = "The name of the SSL-VPN server."
  type        = string
  default     = ""
}

variable "ssl_client_ip_pool" {
  description = "The CIDR block from which access addresses are allocated to the virtual network interface card of the client."
  type        = string
  default     = ""
}

variable "ssl_local_subnet" {
  description = "The CIDR block to be accessed by the client through the SSL-VPN connection."
  type        = string
  default     = ""
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

variable "ssl_port" {
  description = "The port used by the SSL-VPN server. The default value is 1194.The following ports cannot be used: [22, 2222, 22222, 9000, 9001, 9002, 7505, 80, 443, 53, 68, 123, 4510, 4560, 500, 4500]."
  type        = number
  default     = 1194
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
  default     = []
}

#alicloud_vpn_connection
variable "ipsec_connection_name" {
  description = "The name of the IPsec connection."
  type        = string
  default     = ""
}

variable "ipsec_local_subnet" {
  description = "The CIDR block of the VPC to be connected with the local data center. This parameter is used for phase-two negotiation."
  type        = list(string)
  default     = []
}

variable "ipsec_remote_subnet" {
  description = "The CIDR block of the local data center. This parameter is used for phase-two negotiation."
  type        = list(string)
  default     = []
}

variable "ipsec_effect_immediately" {
  description = "Whether to delete a successfully negotiated IPsec tunnel and initiate a negotiation again. Valid value:true,false."
  type        = bool
  default     = false
}

variable "enable_tunnels_bgp" {
  description = "Whether to enable BGP for the tunnels."
  type        = bool
  default     = null
}

variable "tunnel_options_specification" {
  type = list(object({
    role                 = optional(string, null)
    status               = optional(string, null)
    customer_gateway_id  = optional(string, null)
    enable_nat_traversal = optional(bool, null)
    enable_dpd           = optional(bool, null)
    tunnel_ike_config = optional(list(object({
      ike_auth_alg = optional(string, null)
      local_id     = optional(string, null)
      ike_enc_alg  = optional(string, null)
      ike_version  = optional(string, null)
      ike_mode     = optional(string, null)
      ike_lifetime = optional(string, null)
      psk          = optional(string, null)
      remote_id    = optional(string, null)
      ike_pfs      = optional(string, null)
    })), [])
    tunnel_bgp_config = optional(list(object({
      local_asn    = optional(string, null)
      tunnel_cidr  = optional(string, null)
      local_bgp_ip = optional(string, null)
    })), [])
    tunnel_ipsec_config = optional(list(object({
      ipsec_pfs      = optional(string, null)
      ipsec_enc_alg  = optional(string, null)
      ipsec_auth_alg = optional(string, null)
      ipsec_lifetime = optional(number, null)
    })), [])
  }))
  description = "The tunnel options specification config."
  default     = []

}
