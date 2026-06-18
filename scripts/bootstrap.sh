#!/bin/bash
set -e

echo "🚀 Starting Docker Installation..."

# Remove old versions
echo "🧹 Removing old Docker versions (if any)..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

# Update and install required packages
echo "📦 Installing required packages..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
echo "🔑 Adding Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Set up the repository
echo "📁 Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
echo "🐳 Installing Docker Engine..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker
echo "⚙️ Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker


sudo usermod -aG docker ubuntu

#"install nginx"
apt update && apt install nginx -y


echo "✅ Docker Installation Complete!"

echo "📌 Check Docker version:"
docker --version

echo "📌 Check Docker Compose version:"
docker compose version

#install aws cli

sudo apt update

sudo apt install unzip curl -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install


