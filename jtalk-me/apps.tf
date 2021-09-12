
module "jtalkme_live" {
  source         = "./modules/jtalk.me"
  namespace      = "home"
  domains        = var.domains
  database_url   = "${local.atlas_cluster_url_parts.0}://${mongodbatlas_database_user.app_user["home"].username}:${mongodbatlas_database_user.app_user["home"].password}@${local.atlas_cluster_url_parts.1}/home"
  backup_bucket  = "${aws_s3_bucket.jtalkme_backup.bucket}/new"
  aws_key_id     = aws_iam_access_key.jtalkme_backup.id
  aws_key_secret = aws_iam_access_key.jtalkme_backup.secret
  bugsnag_key    = var.jtalkme_bugsnag_key
  app_version    = var.jtalkme_version
}

module "jtalkme_staging" {
  source       = "./modules/jtalk.me"
  namespace    = "home-staging"
  staging      = true
  domains      = [for d in var.domains : "staging.${d}"]
  database_url = "${local.atlas_cluster_url_parts.0}://${mongodbatlas_database_user.app_user["home-staging"].username}:${mongodbatlas_database_user.app_user["home-staging"].password}@${local.atlas_cluster_url_parts.1}/home-staging"
  app_version  = var.jtalkme_staging_version
}

module "digito" {
  source      = "./modules/digito"
  namespace   = "digito"
  domains     = [for d in var.domains : "digito.${d}"]
  app_version = var.digito_version
}
