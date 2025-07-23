locals {

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
  rg_name_k8s                = "rg-${var.environment}-k8s-jpls"
  user_assigned_identity_k8s = "k8s${var.environment}-aks-identity"
  k8s_node_Name              = "k8s${var.environment}dnode"

  k8s_secret_config         = "aks-kubeconfig-${var.environment}-raw"
  username_k8s              = "${var.prefix_name}${var.environment}admin"
  k8s_cluster_name          = "k8s-${var.environment}-cluster"
  k8s_dns_cluster_prefix    = "k8s${var.environment}dns"
  service_principal_name    = "spn${var.environment}${var.environment}"
  k8s_namespace_devops_apps = "${var.environment}-apps-jeanphilippels"
  k8s_pods_name             = "${var.prefix_name}${var.environment}pods"
  k8s_deploy_name           = "${var.prefix_name}-deploy-jeanphilippels"
  k8s_label_name            = "${var.prefix_name}_${var.environment}_apps"
  k8s_container_name        = "${var.prefix_name}-${var.environment}-apps"
  k8s_sa                    = "${var.prefix_name}${var.environment}sa"
  k8s_role_cr_name          = "CR-${var.environment}-DEPLOY"
  k8s_role_cr_name_binding  = "CR-BIND-${var.environment}-DEPLOY"
  k8s_user_identity         = "AKS-${var.environment}-ID"


}