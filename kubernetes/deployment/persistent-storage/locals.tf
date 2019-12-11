locals {
  common_labels = {
    environment = var.environment
    build_number = var.build_number
    managed_by = replace(var.managed_by, " ", "_")
    deployment_name = var.deployment_name
  }
  pod_environment = {
    "DB_NAME" = "magento"
    "REDIS_PORT" = "6379"
    "REDIS_CACHE_DEFAULT_DB" = "0"
    "REDIS_CACHE_PAGE_DB" = "1"
    "REDIS_SESSION_DB" = "2"
  }
}