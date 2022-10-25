variable "transit_gateway_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "identifier" {
  type        = string
  description = "(optional) describe your variable"
}

variable "central_vpcs" {
  type        = any
  description = "(optional) describe your variable"
}

variable "tgw_route_table" {
  type = any
}
