# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# --- examples/central_inspection/outputs.tf ---

output "transit_gateway_id" {
  description = "ID of the AWS Transit Gateway resource."
  value       = module.network-hub.transit_gateway.id
}

output "central_vpcs" {
  description = "Central VPCs created."
  value       = { for k, v in module.network-hub.central_vpcs : k => v.vpc_attributes.id }
}

output "network_firewall" {
  description = "AWS Network Firewall ID."
  value       = module.network-hub.aws_network_firewall.id
}
