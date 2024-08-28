#!/bin/bash
# Update and install necessary packages
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce

# Start Docker service
systemctl start docker
systemctl enable docker

# Pull SonarQube Docker image
docker pull sonarqube:10.6.0-community

# Run SonarQube container
docker run -dit --name sonarqube -p 9000:9000 sonarqube:10.6.0-community

# Set Docker to start SonarQube on boot
docker update --restart always sonarqube


