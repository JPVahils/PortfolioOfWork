
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

variable "cluster_name_k8s" {
  type        = string
  description = "K8s Cluster name"
}

variable "allowed_locations" {
  type        = string
  description = "list of allowed locations"
}
variable "sub_id" {
  type        = string
  description = "subscription id"
}

variable "ten_id" {
  type        = string
  description = "tenant id"
}
