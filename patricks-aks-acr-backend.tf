terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "patricksdemostorage"
    storage_account_name = "patricksdemostorage"
    container_name       = "microservice"
    key                  = "microservice.state"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "patricks-rg" {
  name     = "patricks_blog_acr_aks_rg"
  location = "Germany West Central"
}

resource "azurerm_container_registry" "patricks-acr" {
  name                = "patricksblog"
  sku                 = "Premium"
  resource_group_name = azurerm_resource_group.patricks-rg.name
  location            = azurerm_resource_group.patricks-rg.location
}

resource "azurerm_kubernetes_cluster" "patricks-k8s-cluster" {
  name                = "patricks-aks"
  location            = azurerm_resource_group.patricks-rg.location
  resource_group_name = azurerm_resource_group.patricks-rg.name
  dns_prefix          = "patricks-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_role_assignment" "enablePulling" {
  principal_id                     = azurerm_kubernetes_cluster.patricks-k8s-cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.patricks-acr.id
  skip_service_principal_aad_check = true
}
