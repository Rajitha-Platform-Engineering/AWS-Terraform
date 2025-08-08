resource "aws_s3_bucket" "main" {
  bucket = "terraform-state-test-io"

  tags = {
    Name        = "Terraform State"
    environment = var.environment
  }
}