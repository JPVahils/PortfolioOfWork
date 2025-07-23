output "apps_service_ip" {
  description = "The Public IP Address when user can have access to the apps"
  value       = kubernetes_service.appsk8s.status[0].load_balancer[0].ingress[0].ip
}

output "hpa_name" {
  description = "HPA Name"
  value       = kubernetes_horizontal_pod_autoscaler.hpajpls.metadata[0].name
}

output "cluster_name" {
  description = "Cluster Name"
  value       = var.cluster_name_k8s
}

output "resource_group" {
  description = "Resource Group"
  value       = data.azurerm_kubernetes_cluster.ak8s.resource_group_name
}

output "deploy_apps_name" {
  description = "Deploy name of the app container"
  value       = kubernetes_deployment.appsk8s.metadata[0].name
}

output "deploy_apps_name_namespace" {
  description = "Deploy namespace of the app container"
  value       = kubernetes_deployment.appsk8s.metadata[0].namespace
}