terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "rg-mikhail.kazachonak"
    storage_account_name = "stmkazachonaktf01"
    container_name       = "state"
    key                  = "azure1.tfstate"
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
}
