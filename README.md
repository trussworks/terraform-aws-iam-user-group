This module creates a group named after the "group_name" variable intended to contain IAM users defined in the "user_list".

The group has a policy that only allows the assumption of the IAM roles defined in the "allowed_roles" variable.

__NOTE__: So far you must use this in conjunction with the module "trussworks/mfa/aws" to enforce mfa of the group this module creates.

__Philosophical note__: these groups should map 1:1 to IAM roles defined in your Terraform files. These should be defined in a separate module that could be reused in different accounts across your AWS org. So you may have multiple allowed roles with the same name across your accounts as a variable.

## Terraform Versions

Terraform 0.13 and later. Pin module version to ~> 2.X. Submit pull-requests to master branch.
Terraform 0.12. Pin module version to ~> 1.0.3. Submit pull-requests to terraform011 branch.

## Usage

```hcl
    module "aws_iam_user_group" {
      source         = "trussworks/iam-user-group/aws"
      version = "2.0.0"

      user_list = ["user1", "user2"]
      group_name = "group-name"
      allowed_roles = []
      }
```

## Usage example

```hcl
locals {
  user_list = ["user1", "user2"]
  force_destroy = true
}

resource "aws_iam_user" "user" {
  for_each = toset(local.user_list)
  name     = each.value
}

module "aws_iam_user_group" {
  source         = "trussworks/iam-user-group/aws"
  version = "2.0.0"
  user_list = values(aws_iam_user.user)[*].name
  group_name = "group-name"
  allowed_roles = []
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.user_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.user_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.assume_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.assume_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_roles"></a> [allowed\_roles](#input\_allowed\_roles) | The roles that this group is allowed to assume. | `list(string)` | n/a | yes |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | The name of the group to be created. | `string` | n/a | yes |
| <a name="input_user_list"></a> [user\_list](#input\_user\_list) | List of IAM users to add to the group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | The name of the created group. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

