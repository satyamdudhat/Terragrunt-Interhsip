variable "api_name" {
  description = "Name for the API Gateway"
}
variable "lambda_function_uri" {
  description = "Lambda function invoke_arn"
  type = string
}
variable "lambda_function_name" {
  description = "Lambda fucntion Name ARN"
  type = string
}
variable "api_path_name" {
  type = list(string)
}

#---------------------------------- Status Methods
variable "status_http_methods" {
  type    = list(string)
  default = ["GET"]
}

#------------------------------------ Employee Methods
variable "employee_http_methods" {
  type    = list(string)
  default = ["GET","POST","DELETE","PATCH","PUT"]
}

#------------------------------------ Employees Methods
variable "employees_http_methods" {
  type    = list(string)
  default = ["GET"]
}