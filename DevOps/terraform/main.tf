
module "architecture" {

  source            = "./infra"
  prefix_name       = var.prefix_name
  author            = var.author
  cluster_name_k8s  = local.k8s_cluster_name
  environment       = var.environment
  resource_group    = local.rg_name_k8s
  allowed_locations = var.allowed_locations[0]
  sub_id            = var.subid
  ten_id            = var.tenid

}

module "application" {

  source           = "./apps"
  prefix_name      = var.prefix_name
  author           = var.author
  cluster_name_k8s = module.architecture.kubernetes_cluster_name
  environment      = var.environment
  resource_group   = local.rg_name_k8s
  version_apps     = var.version_apps
  registry_email   = var.registry_email
  registry_login   = var.registry_login
  registry_server  = var.registry_server
  registry_pd      = var.registry_pd

}
