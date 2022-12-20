terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-west-2"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_deployment" "Go-API" {
  metadata {
    name = "go-api"
    labels = {
      nome = "go"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        nome = "go"
      }
    }

    template {
      metadata {
        labels = {
          nome = "go"
        }
      }

      spec {
        container {
          image = "leonardosartorello/go_ci:22"
          name  = "go"
          
          env {
            name  = "HOST"
            value = aws_db_instance.default.address
          }
          env {
            name  = "PORT"
            value = aws_db_instance.default.port
          }
          env {
            name  = "USER"
            value = aws_db_instance.default.username
          }
          env {
            name  = "PASSWORD"
            value = "rootroot"
          }
          env {
            name  = "DBNAME"
            value = aws_db_instance.default.db_name
          }
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/bruno"
              port = 8000
            }

            initial_delay_seconds = 30
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "load-balancer-go-api"
  }
  spec {
    selector = {
      nome = "go"
    }
    port {
      port = 8000
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}
