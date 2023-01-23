![Workflow](https://github.com/superiorops/infra_as_code/actions/workflows/pipeline.yaml/badge.svg)



# Workflow to provision Infra on Azure with Terraform


## Pre-requisites

1. Azure subscription
2. An Azure Service Principal with at least contribute access at the subscription Level


## Inputs

1. GitHub Account
2. Azure Subscription ID
3. Azure service prinicipal with contributor access at the subscription level.


## GitHub Setup

1. Check-in the code to your repository

2. Create the Environment by going to Repository settings :arrow_right:  Environments :arrow_right: New environment

![GitHub Environment](.imgs/github_env.png?raw=true "Add Environment")


## Azure Authentication

1. Create a Service Principal with SDK authorization using the below command

```bash
az ad sp create-for-rbac --name <name_for_the_sp> --role contributor --scopes /subscriptions/<subscription_id>  --sdk-auth
```

![Create Service Principal](.imgs/create_az_sp.png?raw=true "Create Service Principal")


2. Make sure to copy the entire output of the above command.

3. Save the ouput from step 1 as an Environment variable named as `AZ_CREDENTIALS`

4. Also, create the following secrets :
    1. AZURE_SUBSCRIPTION_ID  - Subscription ID of your Azure subscription
    2. AZURE_TENANT_ID        - Tenant ID of your Azure subscription
    3. ARM_CLIENT_ID          - clientid from  output of step 1
    4. ARM_CLIENT_SECRET      - clientsecret from  output of step 1



![github secrets](.imgs/github_repo_secrets.png?raw=true "Create GitHub Secrets")













