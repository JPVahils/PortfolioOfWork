
#---------------- Cluster Role ------------------------ #
#Role for AKS Admin Role to be able to list namespace and do actions on AKS Cluster
resource "kubernetes_cluster_role" "actallow" {
  metadata {
    name = "managed-cluster"
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
  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["list", "get", "create", "delete"]
  }
}

# ------------------------ Cluster Role Binding ------------------------ #
resource "kubernetes_cluster_role_binding" "act_bind" {

  metadata {
    name = "managed-cluster-bind"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "managed-cluster"
  }
  subject {
    kind = "Group"
    name = "Azure Kubernetes Service RBAC Cluster Admin"

  }
}
