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

data "kubernetes_service" "nomeDNS" {
    metadata {
      name = "load-balancer-go-api"
    }
}

output "URL" {
  value = data.kubernetes_service.nomeDNS.status
}
