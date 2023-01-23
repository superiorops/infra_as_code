  ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
 ![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white) ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

![Workflow](https://github.com/superiorops/infra_as_code/actions/workflows/pipeline.yaml/badge.svg)

# Workflow to provision Infra on Azure with Terraform


## Motivation

A simple Infra-As-Code ~~pipelines~~ *Workflow* to demonstrate various features of **GitHub Actions**. 
This *workflow* does the following:
1. Set up required Storage Account and contianer for Terraform remote backend.
2. Create [ or destroy ]multi-tier IaaS infrastructure on Azure with Terraform. The following resources are created
    1. VPC
    2. 3 Subnets - Web, App, DB + Security Group for each subnet
    3. Desired number of VM instances in each subnet 
    4. A Load balancer for Web servers
3. Output the values when "Apply" parameter is used.     

## Tools used

1. Azure CLI
2. Bash 
3. Terraform

## Pre-requisites

1. GitHub Account [with Actions enabled]
2. Azure Subscription ID
3. Azure service prinicipal with contributor access at the subscription level.


## Setup
1. Check-in the code to a repository in your GitHub

2. Create the Environment by going to Repository settings :arrow_right:  Environments :arrow_right: New environment

![GitHub Environment](.imgs/github_env.png?raw=true "Add Environment")

3. Create a Service Principal with SDK authorization using the below command

```bash
az ad sp create-for-rbac --name <name_for_the_sp> --role contributor --scopes /subscriptions/<subscription_id>  --sdk-auth
```

![Create Service Principal](.imgs/create_az_sp.png?raw=true "Create Service Principal")
Applyable named as `AZ_CREDENTIALS`

5. Also, create the following secrets :
    1. AZURE_SUBSCRIPTION_ID  - Subscription ID of your Azure subscription
    2. AZURE_TENANT_ID        - Tenant ID of your Azure subscription
    3. ARM_CLIENT_ID          - clientid from  output of step 1
    4. ARM_CLIENT_SECRET      - clientsecret from  output of step 1

![github secrets](.imgs/github_repo_secrets.png?raw=true "Create GitHub Secrets")



## Provision Infrastructure

To provision Infrastructure update `dev.env` with the required values and update Action env `variable` in `.github/workflows/pipeline.yaml` to `Apply`  and check-in the code to your repository.

To deprovision/delete the infrastructure update update Action env `variable` in `.github/workflows/pipeline.yaml` to `Apply`  and check-in the code to your repository

## Manually run the pipeline. 

This workflow can be triggered manually as well. To run the workflow manually follow the below steps:

1. Go to GitHub repository :arrow_right: Actions :arrow_right: Run Manually

![Manual triger](.imgs/github_manual_trigger.png "Manual Trigger")

2. Choose Action as `Apply` to provision and `Destroy` to delete the infrastructure.






