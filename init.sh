#!/bin/bash

# 下準備

## いろんな定数
BASE_URL="https://raw.githubusercontent.com/hyouhyan/server-init/refs/heads/main/"
CURL_COMMAND="curl -fsSL"

## OS情報取得
. /etc/os-release

## パッケージアップデート
sudo apt update

## OS に応じたスクリプトを実行する関数
run_init_script() {
    local script_name="$1"

    case "$ID" in
        ubuntu|debian)
            $CURL_COMMAND "${BASE_URL}/${ID}/${script_name}" | sh
            ;;
        *)
            echo "unsupported: $ID"
            return 1
            ;;
    esac
}


# 日本語化
run_init_script "init-jp.sh"

## タイムゾーンの変更
sudo timedatectl set-timezone Asia/Tokyo


# Dockerのインストール
run_init_script "init-docker.sh"

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
run_init_script "init-autoupdate.sh"
