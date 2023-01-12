#!/bin/bash

# # Check if Resource Group exists if not create resource group
# if  $(az group exists --name $TF_STATE_RG)
# then
#     echo "$TF_STATE_RG resource group exists"
# else

#     echo "$TF_STATE_RG  doesn't exist creating one"
#     az group create --name $TF_STATE_RG --location $LOCATION
# fi


rndstr=$(sed "s/[^a-z0-9]//g" <<< $(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%*()-+' | fold -w 32 | head -n 1  ) | head -c 4)
echo $rndstr


# Check if Storage Account exists, if not create

# isSA=$(az storage account list --resource-group $TF_STATE_RG --query "[].name" -otsv | grep -i $TF_STORAGE_ACCOUNT_PREFIX )

# echo $isSA

# rndstr=$(sed "s/[^a-z0-9]//g" <<< $(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%*()-+' | fold -w 32 | head -n 1  ) | head -c 4)
# echo $rndstr

# if [[ -z $isSA ]]
# then
#     rndstr=$(sed "s/[^a-z0-9]//g" <<< $(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%*()-+' | fold -w 32 | head -n 1  ) | head -c 4)
#     STORAGE_ACCOUNT=${TF_STORAGE_ACCOUNT_PREFIX}$rndstr
#     echo -e "Storage account with the prefix $TF_STORAGE_ACCOUNT_PREFIX doesn't exist.....  \nCreating $STORAGE_ACCOUNT for the state "
#     az storage account create --name $STORAGE_ACCOUNT \
#                           --resource-group $TF_STATE_RG  \
#                           --location $LOCATION --sku Standard_LRS 

# else
#     echo -e "Storage acocunt with prefix $TF_STORAGE_ACCOUNT_PREFIX exists....\nUsing Storage Account $isSA for the TF state"
#     STORAGE_ACCOUNT=$isSA 
    
# fi

# echo "Creating Container "                 
# az storage container create --name $TF_CONTAINER \
#                             --account-name $STORAGE_ACCOUNT 2> /dev/null

# ACCOUNT_KEY=$(az storage account keys list --resource-group $TF_STATE_RG --account-name $STORAGE_ACCOUNT --query '[0].value' -o tsv)
# export ARM_ACCESS_KEY=$ACCOUNT_KEY

# sed -e "s,#TF_STATE_RG#,$TF_STATE_RG,g" -e "s,#STORAGE_ACCOUNT#,$STORAGE_ACCOUNT,g" \
#     -e "s,#TF_CONTAINER#,${TF_CONTAINER},g" -e "s,#TF_KEY#,${TF_KEY},g" TF/remotebackend.tpl > TF/remotebackend.tf


