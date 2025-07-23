terraform {
  required_version = ">= 1.3.0"
  required_providers {

    azapi = {
      source  = "azure/azapi"
      version = "~>1.15"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71, < 5.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.0"

    }
  }


}
