resource "kubernetes_service" "performance-estimator-service" {
  metadata {
    name      = "performance-estimator"
    namespace = kubernetes_namespace.unity-sps.metadata[0].name
  }
  spec {
    selector = {
      app = "performance-estimator"
    }
    session_affinity = var.deployment_environment != "local" ? null : "ClientIP"
    port {
      protocol    = "TCP"
      port        = var.service_port_map.performance_estimator_service
      target_port = 5000
      node_port   = var.service_type != "NodePort" ? null : var.node_port_map.performance_estimator_service
    }
    type = var.service_type
  }
}


resource "kubernetes_deployment" "performance-estimator" {
  metadata {
    name      = "performance-estimator"
    namespace = kubernetes_namespace.unity-sps.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "performance-estimator"
      }
    }

    template {
      metadata {
        labels = {
          app = "performance-estimator"
        }
      }

      spec {
        container {
          image             = var.docker_images.performance_estimator
          image_pull_policy = "Always"
          name              = "performance-estimator"
          port {
            container_port = 80
          }
        }
        restart_policy = "Always"
      }
    }
  }
}
