#!/bin/bash

# Install dependencies
apt update
apt install -y jq awscli

# Install Docker via snap
snap install docker

# Wait for Docker to be available
sleep 20

# Create docker group if it doesn't exist (usually created automatically by snap)
getent group docker || groupadd docker

# Add current user (ubuntu) to the docker group
usermod -aG docker ubuntu

# Optional: Print message before reboot
echo "User 'ubuntu' added to 'docker' group. Rebooting to apply changes..."

# Reboot to apply group membership
reboot
