resource "aws_iam_user" "terraform" {
  name = "terraform"

  tags = {
    Description = "User to apply terraform migrations with"
  }
}

resource "aws_iam_access_key" "terraform_access_key" {
  user    = aws_iam_user.terraform.name
  pgp_key = data.local_file.gpg_key.content_base64
}
resource "aws_iam_group" "terraform" {
  name = "terraform"
}

resource "aws_iam_user_group_membership" "terraform_membership" {
  user = aws_iam_user.terraform.name

  groups = [
    aws_iam_group.terraform.name,
  ]
}

data "aws_iam_policy_document" "terraform_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_user.terraform.arn,
      ]
    }
  }
}

resource "aws_iam_role" "terraform" {
  name        = "terraform"
  description = "Perform Terraform operations on this account"

  assume_role_policy = data.aws_iam_policy_document.terraform_assume_role_policy.json

  tags = {
    Description = "Role to assume when applying changes with Terraform"
  }
}

data "aws_iam_policy_document" "terraform_policy_access_state_document" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::jtalk.me-terraform-state"
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::jtalk.me-terraform-state/*"
    ]
  }
}

data "aws_iam_policy_document" "terraform_policy_allow_create_destroy_document" {
  statement {
    actions = [
      "ec2:Create*",
      "s3:Create*",
      "ecr:Create*",
      "ecs:Create*",
      "eks:Create*",

      "ec2:Destroy*",
      "s3:Destroy*",
      "ecr:Destroy*",
      "ecs:Destroy*",
      "eks:Destroy*",

      "ec2:List*",
      "s3:List*",
      "ecr:List*",
      "ecs:List*",
      "eks:List*",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "terraform_policy_access_state" {
  name = "terraform-access-state"
  role = aws_iam_role.terraform.name

  policy = data.aws_iam_policy_document.terraform_policy_access_state_document.json
}

resource "aws_iam_role_policy" "terraform_policy_allow_create_destroy" {
  name = "terraform-allow-create-destroy"
  role = aws_iam_role.terraform.name

  policy = data.aws_iam_policy_document.terraform_policy_allow_create_destroy_document.json
}
