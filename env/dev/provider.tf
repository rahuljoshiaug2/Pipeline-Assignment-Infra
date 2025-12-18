terraform {
  required_version = ">= 1.0.0"
  backend "azurerm" {
    resource_group_name = "rg-tfstate-rahul"
    storage_account_name = "rahulstgact02"
    container_name = "tfstate"
    key ="dev_state.tfstate"
  }
 
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.54.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "de1c1815-4f90-412b-9551-d55f0de9407d"
}