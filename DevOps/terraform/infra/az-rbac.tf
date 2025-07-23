
# Get information about the configured Azure subscription

data "azurerm_subscription" "primary" {
}

data "azurerm_role_definition" "builtin" {
  name = "Reader"
}
data "azuread_client_config" "currentad" {}

data "azurerm_client_config" "currents" {}

# SP execute by Terraform
data "azuread_service_principal" "spjplsact" {
  display_name = "az-serviceact"
}


# Create Azure AD Group in Active Directory for AKS Admins

resource "azuread_group" "aks_admin" {
  display_name            = local.azure_Ad_group_admin
  security_enabled        = true
  owners                  = [data.azurerm_client_config.currents.object_id]
  description             = "Azure AKS Kubernetes administrators for the ${local.k8s_cluster_name}"
  prevent_duplicate_names = true
}

resource "azuread_group" "aks_user" {
  display_name            = local.azure_Ad_group_user
  security_enabled        = true
  owners                  = [data.azurerm_client_config.currents.object_id]
  description             = "Azure AKS Kubernetes User-level for the ${local.k8s_cluster_name}"
  prevent_duplicate_names = true
}


resource "azurerm_role_assignment" "adminksvault" {
  principal_id         = azuread_group.aks_admin.object_id
  scope                = azurerm_resource_group.rgaks.id
  role_definition_name = "Key Vault Secrets Officer"
}
resource "azurerm_role_assignment" "adminbckp" {
  principal_id         = azuread_group.aks_admin.object_id
  scope                = azurerm_resource_group.rgaks.id
  role_definition_name = "Storage Account Contributor"
}
resource "azurerm_role_assignment" "adminkss" {
  principal_id         = azuread_group.aks_admin.object_id
  scope                = azurerm_resource_group.rgaks.id
  role_definition_name = "Azure Kubernetes Service RBAC Admin"
}

resource "azurerm_role_assignment" "admin" {
  principal_id         = azuread_group.aks_admin.object_id
  scope                = azurerm_resource_group.rgaks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
}

data "azurerm_role_definition" "aksadminrole" {
  name = "Azure Kubernetes Service RBAC Cluster Admin"
}
resource "azurerm_role_assignment" "user" {
  principal_id         = azuread_group.aks_user.object_id
  scope                = azurerm_resource_group.rgaks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
}


resource "azurerm_role_assignment" "adminksgrafana" {
  principal_id         = azuread_group.aks_admin.object_id
  scope                = azurerm_resource_group.rgaks.id
  role_definition_name = "Grafana Admin"
}

resource "azurerm_role_assignment" "adminmon" {
  principal_id         = azuread_group.aks_admin.object_id
  scope                = azurerm_resource_group.rgaks.id
  role_definition_name = "Monitoring Reader"
}

data "azuread_group" "aksgroup" {
  display_name     = azuread_group.aks_admin.display_name
  security_enabled = true
}
data "azuread_group" "azgroupdevops" {
  display_name     = local.azure_Ad_group_admin_Devops
  security_enabled = true
}

resource "azuread_group_member" "groupmember" {
  group_object_id  = data.azuread_group.aksgroup.object_id
  member_object_id = data.azuread_group.azgroupdevops.object_id
}

resource "azuread_group_member" "groupmemberspaksjpls-act" {
  group_object_id  = data.azuread_group.aksgroup.object_id
  member_object_id = data.azuread_service_principal.spjplsact.object_id
}


resource "azuread_group_member" "groupmemberspaks_msi" {
  depends_on       = [azurerm_kubernetes_cluster.default]
  group_object_id  = data.azuread_group.aksgroup.object_id
  member_object_id = azurerm_kubernetes_cluster.default.identity[0].principal_id
}


resource "azurerm_role_assignment" "aks_sp_role_assignment" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = data.azurerm_role_definition.builtin.name
  principal_id         = data.azuread_service_principal.spjplsact.object_id

}
