
# --------- TRANSIT GATEWAY ROUTE TABLE AND ASSOCATIONS - SPOKE VPCS ---------
resource "aws_ec2_transit_gateway_route_table" "spokes_tgw_rt" {
  transit_gateway_id = var.transit_gateway_id

  tags = {
    Name = "spoke-vpc-tgw-rt-${var.identifier}"
  }
}

# ASSOCIATION TO VPCS WHEN SPOKE VPCS ARE SUPPORTED

# ---------------------- TRANSIT GATEWAY STATIC ROUTES ----------------------
# If both Inspection and Egress VPCs are created, the Inspection TGW Route Table will have a static route to 0.0.0.0/0 with the Egress VPC as destination
resource "aws_ec2_transit_gateway_route" "inspection_to_egress_route" {
  count = length(setintersection(keys(var.central_vpcs), ["inspection", "egress"])) == 2 ? 1 : 0

  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = var.central_vpcs["egress"].transit_gateway_attachment_id
  transit_gateway_route_table_id = var.tgw_route_table["inspection"].id
}

# If both Inspection and Egress VPC are created, the Egress TGW Route Table should only have one route sending all the traffic to the Inspection VPC
resource "aws_ec2_transit_gateway_route" "egress_to_inspection_route" {
  count = length(setintersection(keys(var.central_vpcs), ["inspection", "egress"])) == 2 ? 1 : 0

  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = var.central_vpcs["inspection"].transit_gateway_attachment_id
  transit_gateway_route_table_id = var.tgw_route_table["egress"].id
}

# If both Inspection and Ingress VPC are created, the Ingress TGW Route Table should have a 0.0.0.0/0 route to the Inspection VPC
resource "aws_ec2_transit_gateway_route" "ingress_to_inspection_route" {
  count = length(setintersection(keys(var.central_vpcs), ["inspection", "ingress"])) == 2 ? 1 : 0

  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = var.central_vpcs["inspection"].transit_gateway_attachment_id
  transit_gateway_route_table_id = var.tgw_route_table["ingress"].id
}

# In the Spoke VPCs, the default 0.0.0.0/0 static route destination is going to depend on the existence of the Inspection and Egress VPC
# - If the Inspection VPC is created, regardless of the creation of the Egress VPC, the traffic from the Spoke VPCs will be routed to the Inspection VPC.
# - The default route to 0.0.0.0/0 from the Spoke VPCs will only be routed to the Egress VPC if there's no Inspection VPC created.
# - This route won't exist if there's not Inspection and Egress VPC
resource "aws_ec2_transit_gateway_route" "spokes_static_default_route" {
  count = length(setintersection(keys(var.central_vpcs), ["inspection", "egress"])) > 0 ? 1 : 0

  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = contains(keys(var.central_vpcs), "inspection") ? var.central_vpcs["inspection"].transit_gateway_attachment_id : var.central_vpcs["egress"].transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spokes_tgw_rt.id
}

# -------------------- TRANSIT GATEWAY PROPAGATED ROUTES --------------------
# If the Inspection VPC is created and there's no Egress VPC, all the Spoke VPCs propagate to the Inspection TGW Route Table
#  TO ADD WHEN SUPPORTING SPOKE VPCs

# If the Egress VPC is created and there's no Inspection VPC, all the Spoke VPCs propagate to the Egress TGW Route Table
#  TO ADD WHEN SUPPORTING SPOKE VPCs

# If the Shared Services VPC is created, all the Spokes VPCs propagate to the Shared Services TGW Route Table
#  TO ADD WHEN SUPPORTING SPOKE VPCs

# If there's no Inspection VPC created, all the Spoke VPCs propagate to the Ingress TGW Route Table
#  TO ADD WHEN SUPPORTING SPOKE VPCs

# If the Hybrid DNS VPC is created, all the Spokes VPCs propagate to the Hybrid DNS TGW Route Table
#  TO ADD WHEN SUPPORTING SPOKE VPCs

# If Shared Services VPC is created, it propagates its CIDR to the Spoke VPC TGW Route Table
resource "aws_ec2_transit_gateway_route_table_propagation" "shared_services_to_spokes_propagation" {
  count = try(var.central_vpcs.shared_services, "none") == "none" ? 0 : 1

  transit_gateway_attachment_id  = var.central_vpcs["shared_services"].transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spokes_tgw_rt.id
}

# If Hybrid DNS VPC is created, it propagates its CIDR to the Spoke VPC TGW Route Table
resource "aws_ec2_transit_gateway_route_table_propagation" "hybrid_dns_to_spokes_propagation" {
  count = try(var.central_vpcs.hybrid_dns, "none") == "none" ? 0 : 1

  transit_gateway_attachment_id  = var.central_vpcs["hybrid_dns"].transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spokes_tgw_rt.id
}

