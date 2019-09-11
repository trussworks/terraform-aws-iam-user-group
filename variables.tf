variable "user_names" {
    description = "Create IAM users with these names."
    type = list(string)
    default = []
}

variable "force_destroy_users" {
    description = "Sets 'force_destroy' to true or false for all IAM users generated with this module."
    type = bool
    default = true
}

variable "group_name" {
    description = "The name of the group to be created."
    type = string
}

variable "allowed_roles" {
    description = "The roles that this group is allowed to assume."
    type = list(string)
}
