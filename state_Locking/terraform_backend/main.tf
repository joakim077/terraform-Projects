resource "aws_s3_bucket" "name" {
  bucket = "terraform-state-lock-3498-ihe-343"
  tags = {
    name = "terraform-state-lock-3498-ihe-343"
  }
}

resource "aws_dynamodb_table" "my-backend-table" {
  name = "terrafrom-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name = "terrafrom-state-lock-table"
  }
}