resource "mongodbatlas_project" "atlas_project" {
  name   = "jtalk"
  org_id = var.atlas_org_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "mongodbatlas_cluster" "main_mongodb" {
  project_id             = mongodbatlas_project.atlas_project.id
  name                   = "jtalk"
  cluster_type           = "REPLICASET"
  mongo_db_major_version = "4.4"

  provider_name               = "TENANT"
  provider_region_name        = "EU_WEST_1"
  provider_instance_size_name = "M0"

  auto_scaling_disk_gb_enabled = false

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      mongo_db_major_version,
      state_name,
    ]
  }
}

locals {
  mongodb_databases = ["home", "home-staging"]
  mongodb_app_permissions = [
    "FIND", "INSERT", "REMOVE", "UPDATE",
    "BYPASS_DOCUMENT_VALIDATION", "ENABLE_PROFILER",
    "CREATE_COLLECTION", "CREATE_INDEX", "DROP_COLLECTION", "DROP_INDEX", "RENAME_COLLECTION_SAME_DB",
    "CHANGE_STREAM",
    "COLL_MOD", "COMPACT", "CONVERT_TO_CAPPED", "RE_INDEX",
    "COLL_STATS", "DB_STATS", "DB_HASH", "VALIDATE",
    "LIST_INDEXES", "LIST_COLLECTIONS",
  ]
}

resource "mongodbatlas_custom_db_role" "app_role" {
  for_each   = toset(local.mongodb_databases)
  project_id = mongodbatlas_project.atlas_project.id
  role_name  = each.key

  dynamic "actions" {
    for_each = toset(local.mongodb_app_permissions)

    content {
      action = actions.key
      resources {
        cluster         = false
        collection_name = ""
        database_name   = each.key
      }
    }
  }
}

resource "random_password" "atlas_app_password" {
  for_each = toset(local.mongodb_databases)
  length   = 65
  special  = false // problems with mongodb drivers & escaping
}

resource "mongodbatlas_database_user" "app_user" {
  for_each = toset(local.mongodb_databases)

  project_id = mongodbatlas_project.atlas_project.id

  username = each.key
  password = random_password.atlas_app_password[each.key].result

  auth_database_name = "admin"

  roles {
    role_name     = mongodbatlas_custom_db_role.app_role[each.key].role_name
    database_name = "admin"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "mongodbatlas_project_ip_access_list" "atlas_ip_whitelist" {
  project_id = mongodbatlas_project.atlas_project.id
  cidr_block = "0.0.0.0/0"
}

locals {
  atlas_cluster_url_parts = split("://", mongodbatlas_cluster.main_mongodb.srv_address)
}
