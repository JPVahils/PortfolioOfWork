#!/bin/bash
INITIAL="jpls"
ENVIR="dev"
RESOURCE_GROUP_NAME="rg-${ENVIR}-tfstate-unittest${INITIAL}" 
STORAGE_ACCOUNT_NAME="st541unittest${ENVIR}${INITIAL}"
CONTAINER_NAME="tf-${ENVIR}-tfstate-unittest${INITIAL}"
LOCATION="eastus"
az login --service-principal --username $AZURE_CLIENT_ID --password $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Check if the Resource Group exists
resourceGroup=$(az group show --name "$RESOURCE_GROUP_NAME" --query "name" -o tsv 2>/dev/null)

if [ -z "$resourceGroup" ]; then
    echo "Resource Group '$RESOURCE_GROUP_NAME' does not exist."
    az group create --name $RESOURCE_GROUP_NAME --location $LOCATION
    echo "Resource Group '$RESOURCE_GROUP_NAME' created."
else
    echo "Resource Group '$RESOURCE_GROUP_NAME' already exists."
fi

# Check if the Storage Account exists
storageAccount=$(az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RESOURCE_GROUP_NAME" --query "name" -o tsv 2>/dev/null)

if [ -z "$storageAccount" ]; then
    echo "Storage Account '$STORAGE_ACCOUNT_NAME' does not exist."
    # Create storage account
    az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME  --sku Standard_LRS --encryption-services blob

    echo "Storage Account '$STORAGE_ACCOUNT_NAME' created."
    # Create blob container
    az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME  --resource-group $RESOURCE_GROUP_NAME
else
    echo "Storage Account '$STORAGE_ACCOUNT_NAME' already exists."
fi


