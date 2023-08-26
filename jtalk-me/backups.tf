resource "aws_s3_bucket" "jtalkme_backup" {
  provider = aws.aws_backups

  bucket = "jtalk.me-backup"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "jtalkme_backup" {
  provider = aws.aws_backups

  bucket = aws_s3_bucket.jtalkme_backup.id

  rule {
    id = "live-backup"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    expiration {
      days                         = 60
      expired_object_delete_marker = false
    }

    filter {
      prefix = "live"
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "jtalkme_backup" {
  provider = aws.aws_backups

  bucket = aws_s3_bucket.jtalkme_backup.id
  acl    = "private"
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
