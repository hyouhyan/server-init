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


# VPN用設定
run_init_script "init-vpn.sh"


# サーバ保守関係
run_init_script "init-autoupdate.sh"
