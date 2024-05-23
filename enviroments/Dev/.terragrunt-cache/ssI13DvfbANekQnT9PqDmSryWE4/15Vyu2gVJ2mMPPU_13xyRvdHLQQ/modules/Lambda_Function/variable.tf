variable "function_name" {
  type = string
}

variable "image_uri" {
  type = string
}

variable "iam_role_name" {
  type = string
}

variable "ecr_access_policy" {
    type = string
}

variable "dyanmodb_access_policy" {
    type = string
}

variable "cloudwatch_access_policy" {
    type = string
}