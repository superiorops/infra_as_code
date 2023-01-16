#!/bin/bash

source ./dev.env 2> /dev/null

# Check if Resource Group exists if not create resource group
if  $(az group exists --name $TF_STATE_RG)
then
    echo "$TF_STATE_RG resource group exists"
else

    echo "$TF_STATE_RG  doesn't exist creating one"
    az group create --name $TF_STATE_RG --location $LOCATION
fi


# Check if Storage Account exists| if not create

isSA=$(az storage account list --resource-group $TF_STATE_RG --query "[].name" -otsv | grep -i $TF_STORAGE_ACCOUNT_PREFIX )

if [[ -z $isSA ]]
then
    rndstr=$(tr -dc a-z0-9 </dev/urandom | head -c 5 ; echo '')
    TF_STORAGE_ACCOUNT=${TF_STORAGE_ACCOUNT_PREFIX}$rndstr
    echo -e "Storage account with the prefix $TF_STORAGE_ACCOUNT_PREFIX doesn't exist.....  \nCreating $TF_STORAGE_ACCOUNT for the state "
    az storage account create --name $TF_STORAGE_ACCOUNT \
                          --resource-group $TF_STATE_RG  \
                          --location $LOCATION --sku Standard_LRS 

else
    echo -e "Storage acocunt with prefix $TF_STORAGE_ACCOUNT_PREFIX exists....\nUsing Storage Account $isSA for the TF state"
    TF_STORAGE_ACCOUNT=$isSA 
    
fi

echo "Creating Container "                 
az storage container create --name $TF_CONTAINER \
                            --account-name $TF_STORAGE_ACCOUNT 2> /dev/null

ACCOUNT_KEY=$(az storage account keys list --resource-group $TF_STATE_RG --account-name $TF_STORAGE_ACCOUNT --query '[0].value' -o tsv)
echo "ACCOUNT_KEY=${ARM_ACCESS_KEY}" >> $GITHUB_ENV
echo  "TF_STORAGE_ACCOUNT=${TF_STORAGE_ACCOUNT}" >> $GITHUB_ENV

TF_KEY="tfstate-$ENV"

sed -e 's|#TF_STATE_RG#|'"${TF_STATE_RG}"'|g' -e 's|#TF_STORAGE_ACCOUNT#|'"${TF_STORAGE_ACCOUNT}"'|g' \
    -e 's|#TF_CONTAINER#|'"${TF_CONTAINER}"'|g' -e 's|#TF_KEY#|'"${TF_KEY}"'|g' TF/remotebackend.tpl > TF/remotebackend.tf


sed -e 's|#PREFIX#|'"${PREFIX}"'|g' -e 's|#LOCATION#|'"${LOCATION}"'|g' -e 's|#ENVIRONMENT#|'"${ENV}"'|g' -e 's|#AGENT_INBOUND_PORTS#|'"${AGENT_INBOUND_PORTS}"'|g' -e 's|#AGENT_VM_SIZE#|'"${AGENT_VM_SIZE}"'|g' \
    -e 's|#WEB_INBOUND_PORTS#|'"${WEB_INBOUND_PORTS}"'|g' -e 's|#WEB_VM_SIZE#|'"${WEB_VM_SIZE}"'|g' -e 's|#WEB_NODE_COUNT#|'"${WEB_NODE_COUNT}"'|g' \
    -e 's|#DB_INBOUND_PORTS#|'"${DB_INBOUND_PORTS}"'|g'  -e 's|#DB_VM_SIZE#|'"${DB_VM_SIZE}"'|g' -e 's|#DB_NODE_COUNT#|'"${DB_NODE_COUNT}"'|g' \
    -e 's|#USERNAME#|'"${USERNAME}"'|g' -e 's|#APPLICATION_PORT#|'"${APPLICATION_PORT}"'|g' \
    -e 's|#FRONTEND_PORT#|'"${FRONTEND_PORT}"'|g' TF/terraform.tfvars.tpl > TF/terraform.tfvars


