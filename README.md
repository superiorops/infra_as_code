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

1. Create the Environment



## Azure Authentication

1. Create a Service Principal with SDK authorization using the below command

```bash
az ad sp create-for-rbac --name <name_for_the_sp> --role contributor --scopes /subscriptions/<subscription_id>  --sdk-auth
```

2. Make sure to copy the entire output of the above command.

3. Save the ouput from step1 as an Environment variable named as `AZ_CREDENTIALS`

4. Also, create the following environment variables:
    1. AZURE_SUBSCRIPTION_ID 
    2. AZURE_TENANT_ID
    3. ARM_CLIENT_ID 
    4. ARM_CLIENT_SECRET 
    3. 













