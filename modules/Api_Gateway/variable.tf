variable "api_name" {
  description = "Name for the API Gateway"
}



variable "uri" {
  description = "Lambda function invoke_arn"
  type = string
}

variable "function_name" {
  description = "Lambda fucntion Name ARN"
  type = string
}



variable "api_path_name" {
  type = list(string)
}





#---------------------------------- Status Methods
variable "http_methods_status" {
  type    = list(string)
  default = ["GET"]
}












#------------------------------------ Employee Methods
variable "http_methods_employee" {
  type    = list(string)
  default = ["GET","POST","DELETE","PATCH","PUT"]
}





#------------------------------------ Employees Methods
variable "http_methods_employees" {
  type    = list(string)
  default = ["GET"]
}
