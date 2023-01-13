terraform {

    backend "azurerm" {
        resource_group_name  = "#TF_STATE_RG#"
        storage_account_name = "#TF_STORAGE_ACCOUNT_PREFIX#"
        container_name       = "#TF_CONTAINER#"
        key                  = "#TF_KEY#"
    }

}