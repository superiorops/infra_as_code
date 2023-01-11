terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}



resource "azurerm_resource_group" "myapp" {
  name = "${var.prefix}-rg"
  location = var.location 
  tags = var.tags

}

