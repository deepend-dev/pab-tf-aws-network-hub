<!-- BEGIN_TF_DOCS -->

# AWS Hub and Spoke Architecture with AWS Transit Gateway - Example: Central Shared Services

This example centralizes VPC endpoints with a central Shared Services VPC. The following resources are built:

- Built by the **Hub and Spoke module**:
  - AWS Transit Gateway Route Tables: 1 Inspection, 3 Spokes (production, development, and testing).
  - Transit Gateway routes.
  - Shared Services VPC.
- Built outside the module:
  - AWS Transit Gateway.

## Deployment instructions

- To apply all the resources - `terraform apply`.
- Once you finish your testing remember to delete the resources to avoid having unexpected charges - `terraform destroy`.

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.73.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement_awscc)             | >= 0.15.0 |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 4.32.0  |

## Modules

| Name                                                                 | Source | Version |
| -------------------------------------------------------------------- | ------ | ------- |
| <a name="module_network-hub"></a> [network-hub](#module_network-hub) | ../..  | n/a     |

## Resources

| Name                                                                                                                           | Type     |
| ------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws_ec2_transit_gateway.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |

## Inputs

| Name                                                            | Description                              | Type     | Default                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Required |
| --------------------------------------------------------------- | ---------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region) | AWS Region - to build the Hub and Spoke. | `string` | `"eu-west-1"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |    no    |
| <a name="input_identifier"></a> [identifier](#input_identifier) | Project identifier.                      | `string` | `"central-shared-services"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |    no    |
| <a name="input_spoke_vpcs"></a> [spoke_vpcs](#input_spoke_vpcs) | Spoke VPCs definition.                   | `any`    | <pre>{<br> "dev": {<br> "az_count": 2,<br> "cidr_block": "10.1.0.0/24",<br> "instance_type": "t2.micro",<br> "private_subnet_netmask": 28,<br> "tgw_subnet_netmask": 28,<br> "type": "development"<br> },<br> "prod": {<br> "az_count": 2,<br> "cidr_block": "10.0.0.0/24",<br> "instance_type": "t2.micro",<br> "private_subnet_netmask": 28,<br> "tgw_subnet_netmask": 28,<br> "type": "production"<br> },<br> "test": {<br> "az_count": 2,<br> "cidr_block": "10.2.0.0/24",<br> "instance_type": "t2.micro",<br> "private_subnet_netmask": 28,<br> "tgw_subnet_netmask": 28,<br> "type": "testing"<br> }<br>}</pre> |    no    |

## Outputs

| Name                                                                                      | Description                             |
| ----------------------------------------------------------------------------------------- | --------------------------------------- |
| <a name="output_central_vpcs"></a> [central_vpcs](#output_central_vpcs)                   | Central VPCs created.                   |
| <a name="output_transit_gateway_id"></a> [transit_gateway_id](#output_transit_gateway_id) | ID of the AWS Transit Gateway resource. |

<!-- END_TF_DOCS -->
