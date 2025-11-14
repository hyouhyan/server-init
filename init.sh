#!/bin/bash

# 下準備

## いろんな定数
BASE_URL="https://raw.githubusercontent.com/hyouhyan/server-init/refs/heads/main/"
CURL_COMMAND="curl -fsSL"

## OS情報取得
. /etc/os-release

## パッケージアップデート
sudo apt update


# 日本語化
if [ "$ID" = "ubuntu" ]; then
    $CURL_COMMAND "${BASE_URL}/ubuntu/init-jp.sh" | sh
elif [ "$ID" = "debian" ]; then
    $CURL_COMMAND "${BASE_URL}/debian/init-jp.sh" | sh
else
    echo "unsupported: $ID"
fi


# Dockerのインストール
if [ "$ID" = "ubuntu" ]; then
    $CURL_COMMAND "${BASE_URL}/ubuntu/init-docker.sh" | sh
elif [ "$ID" = "debian" ]; then
    $CURL_COMMAND "${BASE_URL}/debian/init-docker.sh" | sh
else
    echo "unsupported: $ID"
fi


# VPN用設定
if [ "$ID" = "ubuntu" ]; then
    $CURL_COMMAND "${BASE_URL}/ubuntu/init-vpn.sh" | sh
elif [ "$ID" = "debian" ]; then
    $CURL_COMMAND "${BASE_URL}/debian/init-vpn.sh" | sh
else
    echo "unsupported: $ID"
fi


# サーバ保守関係
if [ "$ID" = "ubuntu" ]; then
    $CURL_COMMAND "${BASE_URL}/ubuntu/init-autoupdate.sh" | sh
elif [ "$ID" = "debian" ]; then
    $CURL_COMMAND "${BASE_URL}/debian/init-autoupdate.sh" | sh
else
    echo "unsupported: $ID"
fi
