# Aks and Postgresql Flexible using terraform

This repository contains a flexible setup for deploying PostgreSQL on Azure Kubernetes Service (AKS) using Terraform. It includes a Terraform script for creating an AKS cluster, a PostgreSQL server, and a sample database.



## Getting Started

### Prerequisites: 
 1.  Azure subscription 
   2. Azure CLI installed
   3. Terraform installed

## Installation
1) Clone the repository.
2) Navigate to the repository directory
3) Log in to your Azure account using the Azure CLI:

```bash
az login
```
4) Create SP Login using following command:
```bash 
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID
```
5. Put output from step 4 as credentials in .connection.env file.
6) Modify terraform.tfvars file according to your requirements.
``` bash
resource_group_name = "my-rg"
location = "eastus"
administrator_login = "myadminuser"
administrator_login_password = "P@ssw0rd1234"
aks_node_count = 3
aks_agent_vm_size = "Standard_D2s_v3"
SP_Client_id = "App id returned in step 4"
SP_Client_Secret = "App Password returned in step 4"
```
7) Update backend.conf file according to your storage account which is responsible for storing tfstate in azure storage .
8) Run following command to set azure credentials:
```bash
source ./.connection.env
```
9). Initialize terraform 
``` bash 
 terraform init -backend-config=backend.conf
```
10) Terraform plan
``` bash 
terraform plan -var-file=terraform.tfvars
```
11) Create resources by applying config.
``` bash
terraform apply -var-file=terraform.tfvars
```

## Destroy Infrastructure

For destroying infrastructure run following command
``` bash
terraform destroy -var-file=terraform.tfvars
```
