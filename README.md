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
| terraform | ~> 0.13.0 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_roles | The roles that this group is allowed to assume. | `list(string)` | n/a | yes |
| group\_name | The name of the group to be created. | `string` | n/a | yes |
| user\_list | List of IAM users to add to the group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| group\_name | The name of the created group. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

