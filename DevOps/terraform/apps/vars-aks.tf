variable "k8s_container_port" {
  type        = number
  description = "Container Port"
  default     = 80
}
variable "k8s_version" {
  type        = number
  description = "Kubernetes Version"
  default     = 1.32
}
variable "k8s_replicas" {
  type        = number
  description = "Number of replicas"
  default     = 2
}

variable "k8s_svc_type" {
  type        = string
  description = "IP type of services"
  default     = "LoadBalancer"
}
variable "k8s_svc_port" {
  type        = number
  description = "Service  Port"
  default     = 80
}
variable "k8s_svc_des_port" {
  type        = number
  description = "Service Destination Port"
  default     = 80
}

##HPA##
variable "k8s_hpa_max_replicas" {
  type        = number
  description = "MAX replicas for HPA"
  default     = 5
}
variable "k8s_hpa_min_replicas" {
  type        = number
  description = "MIN replicas for HPA"
  default     = 1
}
variable "k8s_hpa_cpu" {
  type        = number
  description = "CPU Average Utilization"
  default     = 20
}
