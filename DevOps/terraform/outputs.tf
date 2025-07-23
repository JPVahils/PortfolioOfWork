
# ------------------------ APPS ------------------------ #
output "apps_service_ip" {
  description = "The Public IP Address when user can have access to the apps"
  value       = module.application.apps_service_ip
}

output "hpa_name" {
  description = "HPA Name"
  value       = module.application.hpa_name
}

output "cluster_name" {
  description = "Cluster Name"
  value       = module.application.cluster_name
}

output "resource_group" {
  description = "Resource Group"
  value       = module.application.resource_group
}

output "deploy_apps_name" {
  description = "Resource Group"
  value       = module.application.deploy_apps_name
}
output "deploy_apps_name_namespace" {
  description = "Resource Group"
  value       = module.application.deploy_apps_name_namespace
}


# ------------------------ AKS ------------------------ #

output "host" {
  value     = module.architecture.host
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.architecture.cluster_ca_certificate
  sensitive = true
}

output "client_key" {
  value     = module.architecture.client_key
  sensitive = true
}

output "client_certificate" {
  value     = module.architecture.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = module.architecture.kube_config
  sensitive = true
}

output "cluster_username" {
  value     = module.architecture.cluster_username
  sensitive = true
}


output "aks_msi_principal_id" {
  description = "The principal ID of the AKS system-assigned Managed Service Identity."
  value       = module.architecture.aks_msi_principal_id
}

output "aks_msi_id" {
  description = "The ID of the AKS system-assigned Managed Service Identity."
  value       = module.architecture.aks_msi_id
}
