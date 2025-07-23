#!/bin/bash
INITIAL="jpls"
ENVIR="dev"
RESOURCE_GROUP_NAME="rg-${ENVIR}-tfstate-${INITIAL}" 
STORAGE_ACCOUNT_NAME="st541${ENVIR}${INITIAL}"
CONTAINER_NAME="tf-${ENVIR}-tfstate-${INITIAL}"
LOCATION="eastus"

az login --service-principal --username $AZURE_CLIENT_ID --password $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Check if the Resource Group exists
resourceGroup=$(az group show --name "$RESOURCE_GROUP_NAME" --query "name" -o tsv 2>/dev/null)
if [ -z "$resourceGroup" ]; then
    echo "Resource Group '$RESOURCE_GROUP_NAME' does not exist."
else
   az group delete --name $RESOURCE_GROUP_NAME --yes
fi

# Check if the Storage Account exists
storageAccount=$(az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RESOURCE_GROUP_NAME" --query "name" -o tsv 2>/dev/null)
if [ -z "$storageAccount" ]; then
    echo "Storage Account '$STORAGE_ACCOUNT_NAME' does not exist."
  
else
   az storage account delete -n $CONTAINER_NAME -g $RESOURCE_GROUP_NAME --yes
fi






