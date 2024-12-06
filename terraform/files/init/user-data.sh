#!/bin/bash

# Install Docker and Docker Compose
yum update -y
yum install -y docker python3-pip
pip3 install docker-compose

# Add ec2-user to docker group
usermod -a -G docker ec2-user
id ec2-user
newgrp docker

# Start Docker
systemctl enable docker.service
systemctl start docker.service

# Pull and run the Docker container
