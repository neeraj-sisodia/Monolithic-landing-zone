terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-neeraj-prod"
    storage_account_name = "storageaccount130"
    container_name       = "tfstate"
    key                  = "preprod.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "cacae4fb-1d94-4b34-bb54-e94c77b6941c"
}