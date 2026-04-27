#!/bin/bash

# VPN設定モジュール（Tailscale）

## IP forwarding設定
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-vpn.conf > /dev/null
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-vpn.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/99-vpn.conf > /dev/null

## Tailscaleのインストール
curl -fsSL https://tailscale.com/install.sh | sh
