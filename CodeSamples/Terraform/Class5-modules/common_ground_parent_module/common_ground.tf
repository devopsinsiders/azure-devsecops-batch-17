terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-terraformstate"
    storage_account_name = "devops2189"
    container_name       = "tfstate"
    key                  = "common_ground.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1075ec7a-b17a-4f37-bf3f-9d68c4506dc1"
}

module "vineeta_rg" {
  source = "C:\\DevOpsInsiders\\Batch17\\azure-devsecops-batch-17\\CodeSamples\\Terraform\\Class5\\azurerm_resource_group_child_module"
}

module "storage_account" {
  depends_on = [module.vineeta_rg]
  source     = "C:\\DevOpsInsiders\\Batch17\\azure-devsecops-batch-17\\CodeSamples\\Terraform\\Class5\\azurerm_storage_account_child_module"
}


