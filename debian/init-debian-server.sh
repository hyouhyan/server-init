#!/bin/bash

# 下準備

## パッケージアップデート
sudo apt update


# 日本語化

## 日本語フォントとロケールのインストール
sudo apt install -y fonts-noto-cjk locales

## ロケールの生成
sudo sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

## デフォルトの言語変更
sudo update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
sudo timedatectl set-timezone Asia/Tokyo


# Dockerのインストール
## Add Docker's official GPG key:
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

## Dockerのインストール
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

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

## unattended-upgradesをインストール
sudo apt install -y unattended-upgrades

## unattended-upgradesを有効化
sudo cp /usr/share/unattended-upgrades/20auto-upgrades /etc/apt/apt.conf.d/
