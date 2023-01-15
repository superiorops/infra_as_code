# Rename this file to terraform.tfvars afte substituting the values

prefix = "#PREFIX#"
location = "#LOCATION#"

#agent Variables

agent_inbound_ports = #AGENT_INBOUND_PORTS#
agent_vm_size       =  #AGENT_VM_SIZE#

#Web Variables
web_inbound_ports = #WEB_INBOUND_PORTS#
web_vm_size       = #WEB_VM_SIZE#
web_node_count    = 2

#Database Variables
db_inbound_ports = #DB_INBOUND_PORTS#
db_vm_size       = #DB_VM_SIZE#
db_node_count    = 1


#common VM variables
username  = "#USERNAME#"
pubkeypath = id_demo

destination_ssh_key_path = "/home/#ADMINUSER#/.ssh/authorized_keys"
application_port = #APP_PORT#

tags = {
    Project = #PREFIX# 
    DeployMode="Terraform"
    Environment = "#ENVIRONMENT#"
}