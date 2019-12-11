variable "environment" {
  type        = string
  default     = "nonprod"
  description = "The environment that the resource will be deployed into."
}

variable "managed_by" {
  type        = string
  default     = "Mark Revill"
  description = "The name of the product owner or manager that the resource will be associated with."
}

variable "build_number" {
  type        = string
  default     = "Manual"
  description = "The Azure Pipelines build number that the resource was deployed from."
}

variable "deployment_name" {
  type        = string
  default     = "b2c-web"
  description = "Name of the deployment"
}

variable "azure_container_registry" {
  type        = string
  default     = "wwgsharedservicesprodacr.azurecr.io"
  description = "The FQDN of the Azure container registry the image will be sourced from."
}

variable "docker_image_name" {
  type        = string
  default     = "b2c"
  description = "The name of the Docker image to be deployed."
}

variable "docker_tag" {
  type        = string
  default     = "showcase"
  description = "The version of the Docker image to deploy"
}

variable "replicas" {
  type        = string
  default     = "1"
  description = "The number of pods to deploy for availability."
}

variable "limits_cpu" {
  type        = string
  default     = "1"
  description = ""
}

variable "limits_memory" {
  type        = string
  default     = "2Gi"
  description = ""
}

variable "requests_cpu" {
  type        = string
  default     = "125m"
  description = ""
}

variable "requests_memory" {
  type        = string
  default     = "256Mi"
  description = ""
}

variable "pod_urls" {
  type = map
  default = {
    "BASE_URL_DEFAULT" = "http://www.markrevill.dev/"
  }
}

variable "secrets" {
  type = list(map(string))
  default = [
    {
      env_name = "DB_HOST"          # Environment variable name
      secret_name = "mysql-creds"   # Secret name in Kubernetes (e.g. mysql-creds)
      key_name = "hostname"         # Key name in secret that holds value to be stored in Environment
    },
    {
      env_name = "DB_USER"
      secret_name = "mysql-creds"
      key_name = "username"
    },    
    {
      env_name = "DB_PASSWORD"
      secret_name = "mysql-creds"
      key_name = "password"
    },
    {
      env_name = "REDIS_HOST"
      secret_name = "rediscreds"
      key_name = "hostname"
    },
    {
      env_name = "REDIS_PASSWORD"
      secret_name = "rediscreds"
      key_name = "primary_accesskey"
    },
  ]
  description = "A list of environment to Kubernetes secret mappings."
}