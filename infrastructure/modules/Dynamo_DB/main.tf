resource "aws_dynamodb_table" "employee_information_table" {
  name           = var.table_name
  hash_key       = var.hash_key_id
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "employeeid"
    type = "S"
  }
}