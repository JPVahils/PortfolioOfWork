
provider "azurerm" {
  features {

    key_vault {
      purge_soft_delete_on_destroy = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  use_msi = true
}

data "azurerm_kubernetes_cluster" "ak8s" {
  name                = var.cluster_name_k8s
  resource_group_name = var.resource_group
}

provider "kubernetes" {

  host                   = data.azurerm_kubernetes_cluster.ak8s.kube_admin_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.ak8s.kube_admin_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.ak8s.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.ak8s.kube_admin_config.0.cluster_ca_certificate)
}

