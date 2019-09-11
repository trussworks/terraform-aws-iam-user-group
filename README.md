This module creates users based on the "user_names" variable and a group based on the "group_name" variable.
The users are added to the group created.

The group has a policy that only allows the assumption of the IAM roles defined in the "allowed_roles" variable.

The generated users are members of the group "admin-org-root" and have the "force_destroy" flag set to true.

NOTE: So far you must use this in conjunction with the module "trussworks/mfa/aws" to enforce mfa of the group this module creates.

## Usage

```hcl
    module "aws-iam-user-group" {
      # to be finalized
      source         = "trussworks/iam-user-group/aws"

      user_names = ["user1", "user2"]
      group_name = "group-name"
      allowed_roles = []
      }
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_roles | The roles that this group is allowed to assume. | list(string) | n/a | yes |
| force\_destroy\_users | Sets 'force_destroy' to true or false for all IAM users generated with this module. Note:Turning force_destroy off means that a user with IAM permissions will have to go and remove MFA and keys from a user you might be managing this way. | bool | `"true"` | no |
| group\_name | The name of the group to be created. | string | n/a | yes |
| user\_names | Create IAM users with these names. | list(string) | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| group\_name | The name of the created group. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

