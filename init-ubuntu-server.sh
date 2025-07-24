#!/bin/bash

## 日本語化

# 日本語パッケージにインストール
apt -y install language-pack-ja-base language-pack-ja

# デフォルトの言語変更
localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

# タイムゾーンの変更
timedatectl set-timezone Asia/Tokyo


## Dockerのインストール
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# install Dockers
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


## Tailscaleのインストール
curl -fsSL https://tailscale.com/install.sh | sh