
# ------------------------ Resource Group For AKS Cluster ------------------------ #
resource "azurerm_resource_group" "rgaks" {
  name     = var.resource_group
  location = var.allowed_locations
  tags     = local.merge_tags
}

data "azurerm_client_config" "currentsw" {}
resource "azurerm_kubernetes_cluster" "default" {

  depends_on = [azuread_group.aks_admin]


  lifecycle {
    ignore_changes = all
  }
  name                = var.cluster_name_k8s
  location            = azurerm_resource_group.rgaks.location
  resource_group_name = azurerm_resource_group.rgaks.name
  dns_prefix          = local.k8s_dns_cluster_prefix
  kubernetes_version  = var.k8s_version
  node_resource_group = "${azurerm_resource_group.rgaks.name}-nrg"
  default_node_pool {
    name                 = local.k8s_node_Name
    node_count           = var.k8s_node_number
    auto_scaling_enabled = false
    vm_size              = var.k8s_vm_size
    os_disk_size_gb      = var.k8s_os_disk
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = local.username_k8s
    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }
  # Add On Profiles
  azure_policy_enabled = true

  monitor_metrics {
    annotations_allowed = null
    labels_allowed      = null
  }
  role_based_access_control_enabled = true
  azure_active_directory_role_based_access_control {
    tenant_id = data.azurerm_client_config.currentsw.tenant_id
    admin_group_object_ids = [
      azuread_group.aks_admin.object_id
    ]
    azure_rbac_enabled = true


  }

  tags = local.merge_tags


}

##CONFIG 
resource "local_file" "kubeconfig" {

  depends_on = [
    azurerm_kubernetes_cluster.default
  ]

  filename = "./kubeconfig"
  content  = azurerm_kubernetes_cluster.default.kube_config_raw

}

