#!/bin/bash

# サーバ保守設定モジュール

## カーネルパニック時に10秒後に自動再起動する
## （デフォルトの kernel.panic=0 だとパニックで停止したままになり、現地復旧が必要になる）
echo 'kernel.panic = 10' | sudo tee /etc/sysctl.d/99-kernel-panic.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/99-kernel-panic.conf > /dev/null

## unattended-upgradesのインストール
sudo apt-get -q install -y unattended-upgrades

## unattended-upgradesの有効化
sudo cp /usr/share/unattended-upgrades/20auto-upgrades /etc/apt/apt.conf.d/

## Prometheus node exporterのインストール
sudo apt-get -q install -y prometheus-node-exporter

## node exporterの自動起動設定
sudo systemctl enable prometheus-node-exporter
