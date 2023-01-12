#!/bin/bash

ENV=$1
TFSTATERG=$2
SAG=$3
LOCATION=$4
CONTAINERNAME="tfstate"
TFKEY="tfstate-$ENV"

# Check if Resource Group exists if not create resource group
if  $(az group exists --name $TFSTATERG)
then
    echo "$TFSTATERG resource group exists"
else

    echo "$TFSTATERG  doesn't exist creating one"
    az group create --name $TFSTATERG --location $LOCATION
fi


# Check if Storage Account exists, if not create

isSA=$(az storage account list --resource-group $TFSTATERG --query "[].name" -otsv | grep -i $SAG )

echo $isSA

if [[ -z $isSA ]]
then
    rndstr=$(sed "s/[^a-z0-9]//g" <<< $(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%*()-+' | fold -w 32 | head -n 1  ) | head -c 4)
    STORAGEACCOUNT=${SAG}$rndstr
    echo -e "Storage account with the prefix $SAG doesn't exist.....  \nCreating $STORAGEACCOUNT for the state "
    az storage account create --name $STORAGEACCOUNT \
                          --resource-group $TFSTATERG  \
                          --location $LOCATION --sku Standard_LRS 

else
    echo -e "Storage acocunt with prefix $SAG exists....\nUsing Storage Account $isSA for the TF state"
    STORAGEACCOUNT=$isSA 
    
fi


echo "Creating Container "                 
az storage container create --name $CONTAINERNAME \
                            --account-name $STORAGEACCOUNT 2> /dev/null


# ACCOUNT_KEY=$(az storage account keys list --resource-group $TFSTATERG --account-name $STORAGEACCOUNT --query '[0].value' -o tsv)

echo $ACCOUNT_KEY

sed -e "s,#TFSTATERG#,$TFSTATERG,g" -e "s,#STORAGEACCOUNT#,$STORAGEACCOUNT,g" \
    -e "s,#CONTAINERNAME#,${CONTAINERNAME},g" -e "s,#TFKEY#,${TFKEY},g" TF/remotebackend.tpl > TF/remotebackend.tf


