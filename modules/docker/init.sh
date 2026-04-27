#!/bin/bash

# Dockerのインストール・設定モジュール

## Uninstall old versions
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1) 2>/dev/null || true

case "$ID" in
    ubuntu)
        # Add Docker's official GPG key
        sudo apt-get -q install -y ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        # Add the repository to Apt sources
        sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

        sudo apt-get update
        ;;
    debian)
        # Add Docker's official GPG key
        sudo apt-get -q install -y ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        # Add the repository to Apt sources
        sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

        sudo apt update
        ;;
    *)
        echo "Unsupported OS: $ID"
        exit 1
        ;;
esac

## Install Docker
sudo apt-get -q install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Allow running Docker without sudo
sudo usermod -aG docker "$(whoami)"
