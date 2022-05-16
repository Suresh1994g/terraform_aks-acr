# Manual for the patricks-aks-acr.tf Terraform Configuration File

Terraform configuration file for provisioning an Azure Kubernetes Service and an Azure Container Registry

patricks-aks-acr.tf: Provision an AKS and an ACR 

patricks-aks-acr-backend.tf: Provision an AKS and an ACR including connection to the backend for storing StateFile in Blob Container

# Sources for the Terraform File

I'd like to refer to following to links, which I've used for for that example:

[registry.terraform.io - kubernetes cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)

[registry.terraform.io - container registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)

[docs.microsoft.com - container registry skus](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-skus)

# Terraform Commands

## Initialization

Use the Init command for establishing a connection to the backend, use:

```
terraform init
```

## Validation

Use the Validation command for verifying the file

```
terraform validation
```

## Apply

Use the Apply command for conducting the provisioning

```
terraform apply
```
