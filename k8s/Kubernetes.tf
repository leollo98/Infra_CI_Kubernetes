resource "kubernetes_deployment" "Go-API" {
  metadata {
    name = "go-api"
    labels = {
      nome = "Go"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        nome = "Go"
      }
    }

    template {
      metadata {
        labels = {
          nome = "Go"
        }
      }

      spec {
        container {
          image = "leonardosartorello/go_ci:22"
          name  = "django"

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

            initial_delay_seconds = 3
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
      nome = "Go"
    }
    port {
      port = 8000
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}

locals {
  lb_name = split("-", split(".", kubernetes_service.LoadBalancer.status.0.load_balancer.0.ingress.0.hostname).0).0
}

# Read information about the load balancer using the AWS provider.
data "aws_elb" "lbname" {
  name = local.lb_name
}

output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_hostname" {
  value = kubernetes_service.LoadBalancer.status.0.load_balancer.0.ingress.0.hostname
}
