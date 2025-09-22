# terraform init -backend-config=$PWD/.local-backend
# 
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
  }

  backend "local" {
    path         = ".backend/backend.tfstate"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
  default     = "pierre"
}

resource "kubernetes_deployment" "result" {
  metadata {
    name      = "result"
    namespace = var.namespace
    labels = {
      app = "result"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "result"
      }
    }

    template {
      metadata {
        labels = {
          app = "result"
        }
      }

      spec {
        container {
          name  = "result"
          image = "crafteo/example-voting-app-result:1.1-alpine"

          port {
            name           = "result"
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "result" {
  metadata {
    name      = "result"
    namespace = var.namespace
    labels = {
      app = "result"
    }
  }

  spec {
    selector = {
      app = "result"
    }

    port {
      name        = "http"
      port        = 80
      target_port = "result"
    }
    type = "ClusterIP"
  }
}
