#!/bin/bash

# サーバ保守設定モジュール

## unattended-upgradesのインストール
sudo apt-get -q install -y unattended-upgrades

## unattended-upgradesの有効化
sudo cp /usr/share/unattended-upgrades/20auto-upgrades /etc/apt/apt.conf.d/

## Prometheus node exporterのインストール
sudo apt-get -q install -y prometheus-node-exporter

## node exporterの自動起動設定
sudo systemctl enable prometheus-node-exporter
