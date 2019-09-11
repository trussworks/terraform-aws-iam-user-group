#
# Generate IAM users
#

resource "aws_iam_user" "user" {
  for_each = toset(var.user_names)
  name = each.value
  # Set force_destroy = true to make user clean up easier later.
  force_destroy = var.force_destroy_users 
}

#
# IAM group + membership of group 
#

resource "aws_iam_group" "user_group" {
  name = var.group_name
}

resource "aws_iam_group_membership" "user_group" {
  name = "${var.group_name}-membership"

  users = values(aws_iam_user.user)[*].name

  group = aws_iam_group.user_group.name
}

#
# IAM policy to allow the user group to assume the role passed to the module
#

data "aws_iam_policy_document" "assume_role_policy_doc" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = var.allowed_roles
  }
}

resource "aws_iam_policy" "assume_role_policy" {
  name        = "assume-role-${aws_iam_group.user_group.name}"
  path        = "/"
  description = "Allows the ${aws_iam_group.user_group.name} role to be assumed."
  policy      = "${data.aws_iam_policy_document.assume_role_policy_doc.json}"
}

resource "aws_iam_group_policy_attachment" "assume_role_policy_attachment" {
  group      = "${aws_iam_group.user_group.name}"
  policy_arn = "${aws_iam_policy.assume_role_policy.arn}"
}
