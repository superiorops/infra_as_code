#!/usr/bin/env bash
set -x
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -y
sudo apt-get install -y software-properties-common default-jre
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ >  /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update -y 
sudo apt-get install jenkins -y


# Install Docker

sudo apt-get remove docker docker-engine docker.io containerd runc 
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io


# Add Jenkins user to docker group

sudo usermod -aG docker jenkins

# Restart Jenkins to ensure jenkins could run docker comamnds  
sudo systemctl restart jenkins


# Install Maven


sudo apt-get install maven -y


