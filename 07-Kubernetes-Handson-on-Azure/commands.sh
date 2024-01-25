az aks get-credentials \
 --resource-group example-resources \
 --name handsonaks

 az aks create --resource-group "example-resources"  \
 --name handsonaks --node-count 1  \
  --node-vm-size Standard_D2_v2   \
  --generate-ssh-keys


az aks nodepool update --enable-cluster-autoscaler \
 -g "example-resources" --cluster-name handsonaks \
 --name nodepool1 --min-count 1 --max-count 2

 az aks nodepool update --disable-cluster-autoscaler \
 -g "example-resources" --cluster-name handsonaks --name nodepool1
 az aks nodepool scale --node-count 1 -g "example-resources" \
 --cluster-name handsonaks --name nodepool1


 kubectl rollout history deployment frontend

 kubectl get replicaset
 kubectl rollout history deployment frontend


 helm upgrade wp bitnami/wordpress \
--set mariadb.image.tag=10.11.4-debian-11-r0\
--set mariadb.auth.password="uNm2cZsyxX" \
--set mariadb.auth.rootPassword="ZdRCYulpN8" \
--set wordpressPassword="HRORimZ01U" \
&& kubectl get pods -w


git clone https://github.com/PacktPublishing/Hands-on-Kubernetes-on-Azure-Third-Edition Han


kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0/cert-manager.yaml

kubectl create -f certificate-issuer.yaml


kubectl get certificate
kubectl get certificaterequest
kubectl describe certificaterequest

kubectl create -f certificate-issuer-prod.yaml
kubectl apply -f ingress-with-tls-prod.yaml

kubectl delete -f https://github.com/jetstack/cert-manager/releases/
download/v1.1.0/cert-manager.yaml
az aks disable-addons -n handsonaks \
 -g example-resources -a ingress-appgw


 #check env variables
INSTANCE=13
DOCKERID=21783da1a52a0f7d9dc92b21b17ee3b1f69cea132ca724cd5f2632e0d511d42b
VMSS=$(az vmss list --query '[].name' -o tsv)
RGNAME=$(az vmss list --query '[].resourceGroup' -o tsv)

az vmss run-command invoke -g $RGNAME -n $VMSS --command-id \
RunShellScript --instance-id $INSTANCE --scripts \
"crictl inspect --output yaml $DOCKERID" \
-o yaml | grep SECRET

#associate identity to cluster
az aks pod-identity add --resource-group rg-handsonaks \
 --cluster-name handsonaks --namespace default \
  --name csi-to-key-vault \
  --identity-resource-id /subscriptions/95b8de13-fe46-419d-9492-35b76155e655/resourcegroups/csi-key-vault/providers/Microsoft.ManagedIdentity/userAssignedIdentities/csi-key-vault



  #create cluster with POD IDENTITYenable
  
az feature register --name EnablePodIdentityPreview \
 --namespace Microsoft.ContainerService
az extension add --name aks-preview
az aks delete -n handsonaks -g rg-handsonaks --yes

az aks delete -n handsonaks -g example-resources --yes

az aks create -g rg-handsonaks -n handsonaks \
 --enable-managed-identity --enable-pod-identity \
 --network-plugin azure --node-vm-size Standard_DS2_v2 \
 --node-count 2 --generate-ssh-keys


 helm repo add csi-secrets-store-provider-azure \
 https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts

 az aks enable-addons --addons azure-keyvault-secrets-provider --name handsonaks --resource-group rg-handsonaks


#****************
#KEY VAULT IN AKS1

 export SUBSCRIPTION_ID=95b8de13-fe46-419d-9492-35b76155e655
export RESOURCE_GROUP=rg-handsonaks
export UAMI="CSIKEYVAULTAKSFG28"
export KEYVAULT_NAME=csi-keyvault-handson
export CLUSTER_NAME=handsonaks
az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query addonProfiles.azureKeyvaultSecretsProvider.identity.clientId -o tsv

export IDENTITY_CLIENT_ID="$(az identity show -g $RESOURCE_GROUP --name <identity-name> --query 'clientId' -o tsv)"
export KEYVAULT_SCOPE=$(az keyvault show --name $KEYVAULT_NAME --query id -o tsv)

az role assignment create --role "Key Vault Administrator" --assignee 785cdaf1-1b21-4ad9-a4cf-de3ff98f063c --scope $KEYVAULT_SCOPE

az role assignment create --role Key Vault Administrator --assignee <identity-client-id> --scope $KEYVAULT_SCOPE


#****************
#KEY VAULT IN AKS2
 export SUBSCRIPTION_ID=95b8de13-fe46-419d-9492-35b76155e655
export RESOURCE_GROUP=rg-handsonaks
export UAMI="CSIKEYVAULTAKSFG28"
export KEYVAULT_NAME=csi-keyvault-handson
export CLUSTER_NAME=handsonaks

az account set --subscription $SUBSCRIPTION_ID

az identity create --name $UAMI --resource-group $RESOURCE_GROUP

export USER_ASSIGNED_CLIENT_ID="$(az identity show -g $RESOURCE_GROUP --name $UAMI --query 'clientId' -o tsv)"
export IDENTITY_TENANT=$(az aks show --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP --query identity.tenantId -o tsv)

export KEYVAULT_SCOPE=$(az keyvault show --name $KEYVAULT_NAME --query id -o tsv)

az role assignment create --role "Key Vault Administrator" --assignee $USER_ASSIGNED_CLIENT_ID --scope $KEYVAULT_SCOPE

$(az aks show --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --query "oidcIssuerProfile.issuerUrl" -o tsv)

az aks enable-addons --addons azure-keyvault-secrets-provider --name myAKSCluster --resource-group myResourceGroup  --enable-oidc-issuer --enable-workload-identity

#create private cluster

az network vnet create -o table \
 --resource-group rg-handsonaks \
 --name vnet-handsonaks \
    --address-prefixes 192.168.0.0/16 \
 --subnet-name akssubnet \
    --subnet-prefix 192.168.0.0/24
VNET_SUBNET_ID=$(az network vnet subnet show  --resource-group rg-handsonaks  --vnet-name vnet-handsonaks  --name akssubnet --query id -o tsv)
    az identity create --name handsonaks-mi \
 --resource-group rg-handsonaks
IDENTITY_CLIENTID=$(az identity show --name handsonaks-mi  --resource-group rg-handsonaks  --query clientId -o tsv)

az role assignment create --assignee $IDENTITY_CLIENTID \
 --scope $VNET_SUBNET_ID --role Contributor
IDENTITY_ID=$(az identity show --name handsonaks-mi \
 --resource-group rg-handsonaks \
 --query id -o tsv) 


 az aks create \
 --resource-group rg-handsonaks \
 --name handsonaks \
 --vnet-subnet-id $VNET_SUBNET_ID \
 --enable-managed-identity \
 --assign-identity $IDENTITY_ID \
 --enable-private-cluster \
 --node-count 1 \
  --node-vm-size Standard_DS2_v2 \
 --generate-ssh-keys

 az network vnet subnet create \
 --resource-group rg-handsonaks \
 --vnet-name vnet-handsonaks \
 --name vmsubnet \
  --address-prefix 192.168.1.0/24

  VM_SUBNET_ID=$(az network vnet subnet show \
 --resource-group rg-handsonaks \
 --vnet-name vnet-handsonaks \
 --name vmsubnet --query id -o tsv)
az group create -l northeurope \
 --name rg-handsonaks-vm
az vm create --name vm-handsonaks \
 --resource-group rg-handsonaks-vm \
 --image UbuntuLTS \
 --admin-username azureuser \
  --ssh-key-values ~/.ssh/id_rsa.pub \
 --subnet $VM_SUBNET_ID \
  --size Standard_D2_v2

  #use vm like a proxy
  scp ~/.kube/config azureuser@4.245.236.254:~

  #install kubectl
  curl -LO https://dl.k8s.io/release/v1.20.0/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
mkdir .kube
mv config .kube/config



#create cluster with pods enable

az aks create \
 --resource-group rg-handsonaks \
 --name handsonaks \
 --enable-managed-identity \
  --node-count 1 \
  --node-vm-size Standard_DS2_v2 \
 --generate-ssh-keys \
 --network-plugin azure \
 --network-policy azure



#Connecting an application to an Azure database Azure Service Operator (ASO).
az feature register --name EnablePodIdentityPreview \
 --namespace Microsoft.ContainerService

az extension add --name aks-preview

az feature show --name EnablePodIdentityPreview \
 --namespace Microsoft.ContainerService -o table

 az provider register --namespace Microsoft.ContainerService

 client id 3ab7a670-9577-450b-869f-36937066cd28
 /subscriptions/95b8de13-fe46-419d-9492-35b76155e655/resourcegroups/ASO/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aso-mi

 az aks pod-identity add --resource-group rg-handsonaks \
 --cluster-name handsonaks --namespace azureoperator-system \
 --name aso-identity-binding \
 --identity-resource-id /subscriptions/95b8de13-fe46-419d-9492-35b76155e655/resourceGroups/ASO/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aso-mi


 kubectl rollout status -n cert-manager deploy cert-manager-webhook

 helm repo add azureserviceoperator https://raw.githubusercontent.com/Azure/azure-service-operator/master/charts

 azure account show
 #azure service operator to create resources in azure using aks
helm upgrade --install aso2 aso2/azure-service-operator -n azureserviceoperator-system --create-namespace -f values.yaml


#add container registry
az aks update -n handsonaks \
-g rg-handsonaks --attach-acr fg28hansonaks