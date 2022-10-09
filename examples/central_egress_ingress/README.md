<!-- BEGIN_TF_DOCS -->

# AWS Hub and Spoke Architecture with AWS Transit Gateway - Example: Central Egress and Ingress VPCs

This example builds a central Ingress and Egress VPCs. The following resources are built:

- Built by the **Hub and Spoke module**:
  - AWS Transit Gateway Route Tables: 1 Ingress, 1 Egress, 1 Spokes (production).
  - Transit Gateway routes.
  - Ingress and Egress VPC.
- Built outside the module:
  - AWS Transit Gateway.
  - Managed Prefix List

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
| <a name="provider_aws"></a> [aws](#provider_aws) | 4.33.0  |

## Modules

| Name                                                                 | Source | Version |
| -------------------------------------------------------------------- | ------ | ------- |
| <a name="module_network-hub"></a> [network-hub](#module_network-hub) | ../..  | n/a     |

## Resources

| Name                                                                                                                                                   | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws_ec2_managed_prefix_list.network_prefix_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_ec2_transit_gateway.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway)                         | resource |

## Inputs

| Name                                                            | Description                              | Type     | Default                    | Required |
| --------------------------------------------------------------- | ---------------------------------------- | -------- | -------------------------- | :------: |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region) | AWS Region - to build the Hub and Spoke. | `string` | `"eu-west-1"`              |    no    |
| <a name="input_identifier"></a> [identifier](#input_identifier) | Project identifier.                      | `string` | `"central-egress-ingress"` |    no    |

## Outputs

| Name                                                                                      | Description                             |
| ----------------------------------------------------------------------------------------- | --------------------------------------- |
| <a name="output_central_vpcs"></a> [central_vpcs](#output_central_vpcs)                   | Central VPCs created.                   |
| <a name="output_transit_gateway_id"></a> [transit_gateway_id](#output_transit_gateway_id) | ID of the AWS Transit Gateway resource. |

<!-- END_TF_DOCS -->
