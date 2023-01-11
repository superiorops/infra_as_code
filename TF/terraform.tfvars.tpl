# Rename this file to terraform.tfvars afte substituting the values

prefix = "#PREFIX#"
location = "#LOCATION#"

#agent Variables

agent_inbound_ports = ["22", "8080"]
agent_vm_size       = "Standard_B2s"

#Web Variables
web_inbound_ports = ["80", "8080"]
web_vm_size       = "Standard_B1s"
web_node_count    = 2

#Database Variables
db_inbound_ports = ["3306"]
db_vm_size       = "Standard_B1s"
db_node_count    = 1


#common VM variables
username  = "#ADMINUSER#"
pubkeypath = id_demo

destination_ssh_key_path = "/home/#ADMINUSER#/.ssh/authorized_keys"
application_port = "80"

tags = {
    
    DeployMode="Terraform"
    Environment = "#ENVIRONMENT#"
}