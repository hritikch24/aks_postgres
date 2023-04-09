# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "pg" {
  name                = "${var.resource_group_name}-pg-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku {
    name     = "Standard_D4s_v3"
    capacity = 1
    tier     = "GeneralPurpose"
  }
}

# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.resource_group_name}-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  dns_prefix = "${var.resource_group_name}-aks"

  agent_pool_profile {
    name            = "agentpool"
    count           = var.aks_node_count
    vm_size         = var.aks_agent_vm_size
    os_type         = "Linux"
  }

  service_principal {
    client_id     = "SP_CLIENT_ID"
    client_secret = "SP_CLIENT_SECRET"
  }

  role_based_access_control {
    enabled = true
  }

  depends_on = [azurerm_postgresql_flexible_server.pg]
}

# Store the Terraform state file in an Azure storage account
terraform {
  backend "azurerm" {
  }
}

