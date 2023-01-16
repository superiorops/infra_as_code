# Rename this file to terraform.tfvars after substituting the values

# Common Variables 
prefix = "#PREFIX#"
location = "#LOCATION#"

# Agent Variables
agent_inbound_ports = #AGENT_INBOUND_PORTS#
agent_vm_size       =  #AGENT_VM_SIZE#

# Web Variables
web_inbound_ports = #WEB_INBOUND_PORTS#
web_vm_size       = #WEB_VM_SIZE#
web_node_count    = #WEB_NODE_COUNT#

# Database Variables
db_inbound_ports = #DB_INBOUND_PORTS#
db_vm_size       = #DB_VM_SIZE#
db_node_count    = #DB_NODE_COUNT#


# Common VM variables
username  = "#USERNAME#"
pubkeypath = "./id_az.pub"

destination_ssh_key_path = "/home/#USERNAME#/.ssh/authorized_keys"
application_port = #APPLICATION_PORT#

tags = {
    Project = #PREFIX# 
    DeployMode="Terraform"
    Environment = "#ENVIRONMENT#"
}