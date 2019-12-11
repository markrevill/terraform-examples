##############################################
# Kubernetes - Deploy Pods
##############################################

resource "kubernetes_deployment" "b2c" {
  metadata {
    name = var.deployment_name
    labels = local.common_labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = local.common_labels
    }

    template {
      metadata {
        labels = local.common_labels
      }

      spec {
        container {
          image = "${var.azure_container_registry}/${var.docker_image_name}:${var.docker_tag}"
          name  = var.deployment_name

          resources {
            limits {
              cpu    = var.limits_cpu
              memory = var.limits_memory
            }
            requests {
              cpu    = var.requests_cpu
              memory = var.requests_memory
            }
          }
          volume_mount {
            name = "media"
            mount_path = "/mnt/media"
          }
          # volume_mount {
          #   name = "static"
          #   mount_path = "/var/www/html/pub/static"
          # }
          # Environment
          dynamic "env" {
            iterator = environment
            for_each = local.pod_environment
            content {
              name = environment.key
              value = environment.value
            }
          }
          # URLs
          dynamic "env" {
            iterator = url
            for_each = var.pod_urls
            content {
              name = url.key
              value = url.value
            }
          }
          # Secrets
          dynamic "env" {
            for_each = var.secrets
            content {
              name = env.value.env_name
              value_from {
                secret_key_ref {  
                  name = env.value.secret_name
                  key = env.value.key_name
                }
              }
            } 
          }
          # liveness_probe {
          #   http_get {
          #     path = "/index.php"
          #     port = 80

          #     http_header {
          #       name  = "Host"
          #       value = "hy-au.local"
          #     }
          #   }
          #   initial_delay_seconds = 500
          #   period_seconds        = 10
          #   timeout_seconds       = 5
          #   success_threshold     = 1
          #   failure_threshold     = 6
          # }
          # readiness_probe {
          #   http_get { 
          #     path = "/index.php"
          #     port = 80

          #     http_header {
          #       name  = "Host"
          #       value = "hy-au.local"
          #     }
          #   }
          #   initial_delay_seconds = 200
          #   period_seconds        = 10
          #   timeout_seconds       = 3
          #   success_threshold     = 2
          #   failure_threshold     = 6
          # }
        }
        volume {
          name = "media"
          azure_file {
            secret_name = "storage-creds"
            share_name = "media"   
            read_only = false
          }
        }
        volume {
          name = "static"
          azure_file {
            secret_name = "storage-creds"
            share_name = "static"   
            read_only = false
          }
        }
      }
    }
  }
}