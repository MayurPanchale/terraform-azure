terraform {
  backend "azurerm" {
    resource_group_name  = "demo-resources"
    storage_account_name = "mvpstorage33"
    container_name       = "prod-tfstate"
    key                  = "terraform.tfstate"
  }
}
