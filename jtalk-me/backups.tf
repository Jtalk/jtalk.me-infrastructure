resource "aws_s3_bucket" "jtalkme_backup" {
  provider = aws.aws_backups

  bucket = "jtalk.me-backup"
  acl    = "private"

  lifecycle_rule {
    id      = "live-backup"
    prefix  = "live"
    enabled = true

    abort_incomplete_multipart_upload_days = 1

    expiration {
      days = 60
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "jtalkme_backup" {
  name = "jtalk.me-backup-upload"

  tags = {
    Description = "User to upload database backups from jtalk.me"
    service     = "jtalk.me"
    type        = "backup"
  }
}

resource "aws_iam_access_key" "jtalkme_backup" {
  user = aws_iam_user.jtalkme_backup.name
}

data "aws_iam_policy_document" "jtalkme_backup_policy_document" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.jtalkme_backup.arn
    ]
  }
  statement {
    actions = [
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.jtalkme_backup.arn}/*"
    ]
  }
}

resource "aws_iam_user_policy" "jtalkme_backup_policy" {
  name = "allow-jtalk.me-backup"
  user = aws_iam_user.jtalkme_backup.name

  policy = data.aws_iam_policy_document.jtalkme_backup_policy_document.json
}
