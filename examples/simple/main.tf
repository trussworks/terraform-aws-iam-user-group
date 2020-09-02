data "aws_caller_identity" "current" {}

// create a test user to add
locals {
  test_users = [
    "${var.test_name}-foo",
    "${var.test_name}-bar"
  ]
}

resource "aws_iam_user" "test_users" {
  for_each      = toset(local.test_users)
  name          = each.value
  force_destroy = true
}

// create a test role
data "aws_iam_policy_document" "user_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    # only allow folks in this account
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    # only allow folks with MFA
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role" "test_role" {
  name               = "${var.test_name}-role"
  assume_role_policy = data.aws_iam_policy_document.user_assume_role_policy.json
}


resource "aws_iam_role_policy_attachment" "test_role_readonly_access" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

// test the gruop
module "test_group" {
  source = "../../"

  user_list = values(aws_iam_user.test_users)[*].name
  allowed_roles = [
    aws_iam_role.test_role.arn,
  ]
  group_name = "${var.test_name}-group"
}
