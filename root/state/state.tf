resource "aws_s3_bucket" "terraform-state" {
  bucket = "jtalk.me-terraform-state"
  acl    = "private"

  tags = {
    Name        = "Terraform State"
    Description = "Stores the global state for Terraform"
    Provider    = "Terraform"
  }
}

resource "aws_s3_bucket" "terraform-state-iam" {
  bucket = "jtalk.me-terraform-state-iam"
  acl    = "private"

  tags = {
    Name        = "Terraform State for IAM"
    Description = "Stores the global state for the Terraform IAM user setup"
    Provider    = "Terraform"
  }
}
