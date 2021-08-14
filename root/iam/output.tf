output "terraform_key_secret" {
    value = aws_iam_access_key.terraform_access_key.encrypted_secret
    description = "The access key of the terraform user"
}

output "terraform_key_id" {
    value = aws_iam_access_key.terraform_access_key.id
    description = "The access key ID of the terraform user"
}