#!/usr/bin/env bash
set -x
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt install software-properties-common -y 
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y


# Install Maven
sudo apt-get install maven -y

# Install Azure CLI

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash  

# Disable hostkey checking 
sudo sed -i 's/#host_key_checking/host_key_checking/g' /etc/ansible/ansible.cfg
sudo sed -i '/host_key_checking/s/False/True/g' /etc/ansible/ansible.cfg

#disable deprecation_warnings = True
sudo sed -i 's/#deprecation_warnings/deprecation_warnings/g' /etc/ansible/ansible.cfg
sudo sed -i '/deprecation_warnings/s/True/False/g'  /etc/ansible/ansible.cfg 




