# ----------------------------------------
# 11. DYNAMODB SESSION TABLE
# ----------------------------------------
resource "aws_dynamodb_table" "sessions" {
  name         = "Exam-Sessions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "SessionId"

  attribute {
    name = "SessionId"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name = "Exam-Sessions"
  }
}