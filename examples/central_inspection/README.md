<!-- BEGIN_TF_DOCS -->

# AWS Hub and Spoke Architecture with AWS Transit Gateway - Example: Central Inspection

This example centralizes the traffic inspection and egress traffic within the same VPC, with a central Inspection VPC with public subnets. The following resources are built:

- Built by the **Hub and Spoke module**:
  - AWS Transit Gateway.
  - AWS Transit Gateway Route Tables: 1 Inspection, 2 Spokes (production and non-production).
  - Transit Gateway routes.
  - Inspection VPC - with public subnets for Internet access.
  - AWS Network Firewall (and routes in the Inspection VPC to the firewall endpoints).
- Built outside the module:
  - AWS Network Firewall policy and rule groups - check the _policy.tf_ file.

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
| <a name="provider_aws"></a> [aws](#provider_aws) | 4.31.0  |

## Modules

| Name                                                                 | Source | Version |
| -------------------------------------------------------------------- | ------ | ------- |
| <a name="module_network-hub"></a> [network-hub](#module_network-hub) | ../..  | n/a     |

## Resources

| Name                                                                                                                                                           | Type     |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_networkfirewall_firewall_policy.anfw_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy) | resource |
| [aws_networkfirewall_rule_group.allow_domains](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group)         | resource |
| [aws_networkfirewall_rule_group.drop_remote](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group)           | resource |

## Inputs

| Name                                                            | Description                              | Type     | Default                | Required |
| --------------------------------------------------------------- | ---------------------------------------- | -------- | ---------------------- | :------: |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region) | AWS Region - to build the Hub and Spoke. | `string` | `"eu-west-1"`          |    no    |
| <a name="input_identifier"></a> [identifier](#input_identifier) | Project identifier.                      | `string` | `"central-inspection"` |    no    |

## Outputs

| Name                                                                                      | Description                             |
| ----------------------------------------------------------------------------------------- | --------------------------------------- |
| <a name="output_central_vpcs"></a> [central_vpcs](#output_central_vpcs)                   | Central VPCs created.                   |
| <a name="output_network_firewall"></a> [network_firewall](#output_network_firewall)       | AWS Network Firewall ID.                |
| <a name="output_transit_gateway_id"></a> [transit_gateway_id](#output_transit_gateway_id) | ID of the AWS Transit Gateway resource. |

<!-- END_TF_DOCS -->
