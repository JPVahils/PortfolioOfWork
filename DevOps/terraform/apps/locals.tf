locals {


  default_tags = {

    company      = "OldSchool"
    managed_by   = "terraform"
    type         = "apps"
    "department" = "devops"
  }
  environment_tags = {
    environment = "dev"
    cost_center = "cc-123"
  }


  merge_tags = merge(local.default_tags, local.environment_tags)

  ## ---------------------------------------------------
  # ------------------------ APPS DOCKER CONTAINER SECRETS  ------------------------ #
  ## ---------------------------------------------------
  registry_username   = var.registry_login
  registry_pd         = var.registry_pd
  registry_email      = var.registry_email
  registry_server     = var.registry_server
  docker_repo_name    = "${var.prefix_name}-${var.author}"
  docker_repo_version = var.version_apps
  docker_img          = "${var.registry_login}/${local.docker_repo_name}:${local.docker_repo_version}"
  k8s_secrets_docker  = "${var.prefix_name}-${var.environment}-sec"
  auth_encode         = base64encode("${local.registry_username}:${local.registry_pd}")

  ## ---------------------------------------------------
  # ------------------------ GROUP AD  ------------------------ #
  ## ---------------------------------------------------
  azure_Ad_group_admin = "k8s_admin"
  azure_Ad_group_user  = "k8s_user"

  ## ---------------------------------------------------
  # ------------------------ KV ------------------------ #
  ## ---------------------------------------------------

  keyvault_name = "kv${var.environment}tenantid"

  ## ---------------------------------------------------
  # ------------------------ AKS Cluster ------------------------ #
  ## ---------------------------------------------------

  user_assigned_identity_k8s = "k8s${var.environment}-aks-identity"
  k8s_node_Name              = "k8s${var.environment}dnode"

  k8s_secret_config         = "aks-kubeconfig-${var.environment}-raw"
  username_k8s              = "${var.prefix_name}${var.environment}admin"
  k8s_dns_cluster_prefix    = "k8s${var.environment}dns"
  service_principal_name    = "spn${var.environment}${var.environment}"
  SUB_ID                    = ""
  k8s_namespace_devops_apps = "${var.environment}-apps-${var.author}"
  k8s_pods_name             = "${var.prefix_name}${var.environment}pods"
  k8s_deploy_name           = "${var.prefix_name}-deploy-${var.author}"
  k8s_label_name            = "${var.prefix_name}_${var.environment}_apps"
  k8s_container_name        = "${var.prefix_name}-${var.environment}-apps"
  k8s_sa                    = "${var.prefix_name}${var.environment}sa"
  k8s_role_cr_name          = "CR-${var.environment}-DEPLOY"
  k8s_role_cr_name_binding  = "CR-BIND-${var.environment}-DEPLOY"
  k8s_user_identity         = "AKS-${var.environment}-ID"

  ## ---------------------------------------------------
  # ------------------------ POD AKS DEPLOY ------------------------ #
  ## ---------------------------------------------------

  k8s_hpa_name = "k8s-hpa-${var.environment}-${var.author}"


}