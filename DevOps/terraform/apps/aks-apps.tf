# ------------------------ AKS APPLICATIONS ------------------------ #
#Kubernetes namespace to hold application
resource "kubernetes_namespace" "tf_k8s_ns" {

  metadata {
    name = local.k8s_namespace_devops_apps
    labels = {
      environment = local.environment_tags["environment"]
      managed_by  = local.default_tags["managed_by"]
      type        = local.default_tags["type"]
      department  = local.default_tags["department"]
    }
  }
}

# ------------------------  Secrets ------------------------ #
resource "kubernetes_secret" "adsec" {
  metadata {
    name      = local.k8s_secrets_docker
    namespace = kubernetes_namespace.tf_k8s_ns.metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${local.registry_server}" = {
          "username" = local.registry_username
          "password" = local.registry_pd
          "email"    = local.registry_email
          "auth"     = base64encode("${local.registry_username}:${local.registry_pd}")
        }
      }
    })
  }
}

#Kubernetes service to access the Apps webpage
resource "kubernetes_service" "appsk8s" {

  metadata {
    name      = local.k8s_pods_name
    namespace = kubernetes_namespace.tf_k8s_ns.metadata[0].name
  }
  spec {
    selector = {
      app         = "${local.k8s_label_name}"
      version     = "${var.version_apps}"
      environment = local.environment_tags["environment"]
      managed_by  = local.default_tags["managed_by"]
      type        = local.default_tags["type"]
      department  = local.default_tags["department"]
    }
    port {
      port        = var.k8s_svc_port
      target_port = var.k8s_svc_des_port
    }
    type = var.k8s_svc_type
  }

}


#Kubernetes deployment 
resource "kubernetes_deployment" "appsk8s" {
  depends_on = [
    kubernetes_namespace.tf_k8s_ns,
    kubernetes_service_account.sa_apps,
    kubernetes_secret.adsec,
    kubernetes_cluster_role.allow_deploy,
    kubernetes_cluster_role_binding.allow_deploy, kubernetes_service.appsk8s
  ]
  metadata {
    name      = local.k8s_deploy_name
    namespace = kubernetes_namespace.tf_k8s_ns.metadata[0].name
    labels = {
      app         = "${local.k8s_label_name}"
      version     = "${var.version_apps}"
      environment = local.environment_tags["environment"]
      managed_by  = local.default_tags["managed_by"]
      type        = local.default_tags["type"]
      department  = local.default_tags["department"]
    }
  }

  spec {
    replicas = var.k8s_replicas
    selector {
      match_labels = {
        app         = "${local.k8s_label_name}"
        version     = "${var.version_apps}"
        environment = local.environment_tags["environment"]
        managed_by  = local.default_tags["managed_by"]
        type        = local.default_tags["type"]
        department  = local.default_tags["department"]
      }
    }

    template {
      metadata {
        labels = {
          app         = "${local.k8s_label_name}"
          version     = "${var.version_apps}"
          environment = local.environment_tags["environment"]
          managed_by  = local.default_tags["managed_by"]
          type        = local.default_tags["type"]
          department  = local.default_tags["department"]
        }
      }

      spec {
        service_account_name = local.k8s_sa
        container {
          name  = local.k8s_container_name
          image = local.docker_img

          readiness_probe {
            http_get {
              path = "/"
              port = var.k8s_container_port
            }

            initial_delay_seconds = 10
            period_seconds        = 5
            failure_threshold     = 3

          }


          liveness_probe {
            http_get {

              path = "/"
              port = var.k8s_container_port
            }

            initial_delay_seconds = 10
            period_seconds        = 5
            failure_threshold     = 3
          }

          resources {
            limits = {
              cpu    = "20m"
              memory = "80Mi"
            }
            requests = {
              cpu    = "10m"
              memory = "20Mi"
            }
          }

          port {
            container_port = var.k8s_container_port
          }
        }
        image_pull_secrets {
          name = kubernetes_secret.adsec.metadata.0.name
        }
      }

    }
    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = "1" # Number of pods that can be created above the desired number of pods
        max_unavailable = "1" # Number of pods that can be unavailable during the update
      }

    }

  }

  timeouts {
    create = "3m" # Timeout for creating the deployment
    update = "5m" # Timeout for updating the deployment
    delete = "5m" # Timeout for deleting the deployment
  }

  wait_for_rollout = false
}


#Kubernetes HPA
resource "kubernetes_horizontal_pod_autoscaler" "hpajpls" {
  metadata {
    name      = local.k8s_hpa_name
    namespace = kubernetes_namespace.tf_k8s_ns.metadata[0].name
    labels = {
      app         = "${local.k8s_label_name}"
      version     = "${var.version_apps}"
      environment = local.environment_tags["environment"]
      managed_by  = local.default_tags["managed_by"]
      type        = local.default_tags["type"]
      department  = local.default_tags["department"]
    }
  }

  spec {
    max_replicas = var.k8s_hpa_max_replicas
    min_replicas = var.k8s_hpa_min_replicas

    target_cpu_utilization_percentage = var.k8s_hpa_cpu

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.appsk8s.metadata[0].name
    }
  }
}

