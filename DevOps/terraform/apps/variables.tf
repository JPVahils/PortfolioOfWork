
variable "prefix_name" {
  type        = string
  description = "Prefix"
}
variable "author" {
  type        = string
  description = "Author of the Deployment"
}

variable "resource_group" {
  type        = string
  description = "Resource Group of the resource"
}
variable "environment" {
  type        = string
  description = "Environment name (e.g, dev, prod, staging)"

}
variable "version_apps" {
  type        = string
  description = "Version of the Apps"

}
variable "cluster_name_k8s" {
  type        = string
  description = "K8s Cluster name"
}

variable "registry_login" {
  description = "Login Authentification Registry"
  default     = ""
}

variable "registry_pd" {
  description = "Secret Authentification Registry"
  default     = ""
}

variable "registry_email" {
  description = "Email of the repository"
  default     = ""
}

variable "registry_server" {
  description = "Registry Server"
  default     = ""
}