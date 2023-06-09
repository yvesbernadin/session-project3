resource "aws_dynamodb_table" "dynamodb-table-project3" {
  name           = "userseverless"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "UserId"
  range_key      = "EmployeeName"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "EmployeeName"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Name        = "dynamodb-table-static-"
    Environment = "dev"
  }
}