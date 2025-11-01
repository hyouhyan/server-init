#!/bin/bash

# 日本語化

## 日本語パッケージにインストール
apt -y install language-pack-ja-base language-pack-ja

## デフォルトの言語変更
localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

## タイムゾーンの変更
timedatectl set-timezone Asia/Tokyo


# Dockerのインストール
## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

## Dockerのインストール
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## sudoなしでDockerを動かせるようにする
sudo usermod -aG docker $(echo $USER)


# VPN用設定

## フォワーディングの許可
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-vpn.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-vpn.conf
sudo sysctl -p /etc/sysctl.d/99-vpn.conf

## Tailscaleのインストール(if necessary)
# curl -fsSL https://tailscale.com/install.sh | sh

# サーバ保守関係
## cronによる自動アップグレード
sudo crontab -l; echo "0 0,12 * * * /usr/bin/apt update; /usr/bin/apt dist-upgrade -y > /dev/null 2>&1" | sudo crontab -
