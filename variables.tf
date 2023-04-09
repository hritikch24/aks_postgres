variable "resource_group_name" {
  description = "The name of the resource group to create."
}

variable "location" {
  description = "The location to create the resources in."
}

variable "administrator_login" {
  description = "The administrator login for the PostgreSQL server."
}

variable "administrator_login_password" {
  description = "The administrator login password for the PostgreSQL server."
}

variable "aks_node_count" {
  description = "The number of nodes to create in the AKS cluster."
}

variable "aks_agent_vm_size" {
  description = "The VM size to use for the AKS agent nodes."
}

