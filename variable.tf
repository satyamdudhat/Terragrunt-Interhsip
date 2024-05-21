# Account All Details
variable "profile" {
  type = string
  default = "satyam"
}

#---------------------------Resourse Name 
variable "api_name" {
  type = string
}

variable "table_name" {
  type = string
}

variable "ecr_name" {
  type = string
}

variable "function_name" {
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

