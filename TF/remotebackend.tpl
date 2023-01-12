terraform {

    backend "azurerm" {
        resource_group_name  = "#TFSTATERG#"
        storage_account_name = "#STORAGEACCOUNT#"
        container_name       = "#CONTAINERNAME#"
        key                  = "#TFKEY#"
    }

}