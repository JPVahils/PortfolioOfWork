
variable "k8s_version" {
  type        = number
  description = "Kubernetes Version"
  default     = 1.32
}
variable "k8s_replicas" {
  type        = number
  description = "Number of replicas"
  default     = 1
}

variable "k8s_node_number" {
  type        = number
  description = "Node count"
  default     = 2
}

variable "k8s_vm_size" {
  type        = string
  description = "Type of VM"
  default     = "Standard_D2_v2"
}
variable "k8s_os_disk" {
  type        = number
  description = "OS disk size GB"
  default     = 60
}

