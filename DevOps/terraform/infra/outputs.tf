
# ------------------------ Resource Group For AKS Cluster ------------------------ #

output "resource_group_name" {
  description = "Resource Group of the AKS Cluster"
  value       = azurerm_resource_group.rgaks.name
}
output "kubernetes_cluster_name" {
  description = " AKS Cluster's Name"
  value       = azurerm_kubernetes_cluster.default.name
}


output "host" {
  description = " AKS's Host"
  value       = azurerm_kubernetes_cluster.default.kube_config.0.host
  sensitive   = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.client_key
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.default.kube_config_raw
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.username
  sensitive = true
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.password
  sensitive = true
}
output "aks_msi_principal_id" {
  description = "The principal ID of the AKS system-assigned Managed Service Identity."
  value       = azurerm_kubernetes_cluster.default.identity[0].principal_id
}

output "aks_msi_id" {
  description = "The ID of the AKS system-assigned Managed Service Identity."
  value       = azurerm_kubernetes_cluster.default.identity[0].identity_ids
}
