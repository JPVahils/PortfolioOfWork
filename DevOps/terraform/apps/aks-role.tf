

# ------------------------ Service account ------------------------ #
resource "kubernetes_service_account" "sa_apps" {
  metadata {
    name      = local.k8s_sa
    namespace = local.k8s_namespace_devops_apps
  }
  image_pull_secret {
    name = kubernetes_secret.adsec.metadata.0.name
  }

}

# ------------------------ Cluster Role ------------------------ #
resource "kubernetes_cluster_role" "allow_deploy" {
  metadata {
    name = local.k8s_role_cr_name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["list", "get", "watch", "create", "delete"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods/exec"]
    verbs      = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods/log"]
    verbs      = ["get"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods/attach"]
    verbs      = ["list", "get", "create", "delete", "update"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["list", "get", "create", "delete", "update"]
  }
  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["list", "get", "create", "delete", "update"]
  }
  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["list", "get", "create", "delete", "update", "patch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["list", "get", "create", "delete", "update", "patch"]
  }
}

# ------------------------ Cluster Role Binding ------------------------ #
resource "kubernetes_cluster_role_binding" "allow_deploy" {
  metadata {
    name = local.k8s_role_cr_name_binding
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.allow_deploy.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.sa_apps.metadata.0.name
    namespace = kubernetes_namespace.tf_k8s_ns.metadata[0].name
  }
}
