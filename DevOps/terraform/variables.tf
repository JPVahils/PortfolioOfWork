variable "author" {
  description = "Author of the deployment"
  default     = "jeanphilippels"

}
variable "environment" {
  type        = string
  description = "Environment name (e.g, dev, prod, staging)"
  default     = "dev"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Enter the valid value for the env"
  }

}

variable "stage" {
  type        = string
  description = "Stage name (e.g, alpha, beta, release)"
  default     = "alpha"
  validation {
    condition     = contains(["alpha", "beta", "release"], var.stage)
    error_message = "Enter the valid value for the stage"
  }

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
  description = "Server of the repository"
  default     = ""

}

variable "resource_group_name" {
  description = "Resource Group Name for the Backend"

}

variable "storage_account_name" {
  description = "Storage Account for the backend"

}

variable "container_name" {
  description = "Container Name for the backend"

}
variable "key" {
  description = "Key for the TF State of the backend"

}

variable "prefix_name" {
  type        = string
  description = "Prefix"
  default     = "devops"
}

variable "subid" {
  type        = string
  description = "Subid"
  default     = ""
}
variable "tenid" {
  type        = string
  description = "Tenantid"
  default     = ""
}

variable "allowed_locations" {
  type        = list(string)
  description = "list of allowed locations"
  default     = ["East US", "East US 2"]
}
variable "allowed_locations_name" {
  type        = list(string)
  description = "list of allowed locations name"
  default     = ["eastus", "eastus2"]
}

variable "version_apps" {
  type        = string
  description = "Version of the Apps"
  default     = "V1.0"
}
