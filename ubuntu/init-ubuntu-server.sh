#!/bin/bash

# 下準備

## パッケージアップデート
sudo apt update








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
