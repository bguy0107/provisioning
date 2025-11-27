!#/bin/bash
# This script downloads all updates after a fresh Ubuntu install and installs Docker compose and its depencies

echo "Updating Ubuntu packages..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install nano
sudo apt install net-tools

echo "All system upgrades installed, installing docker repository dependencies..."

sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

echo "Docker repository dependencies installed, installing docker engine and docker compose..."
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
echo "Docker engine and docker compose installed."
echo "Verifying docker installation..."
sudo docker --version
sudo docker compose version
echo "Docker installation verified."
echo "Docker setup complete."
