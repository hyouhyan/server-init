#!/bin/bash

# 日本語化モジュール

case "$ID" in
    ubuntu)
        sudo apt-get -q -y install language-pack-ja-base language-pack-ja
        sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
        ;;
    debian)
        sudo apt-get -q install -y fonts-noto-cjk locales
        sudo sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
        sudo locale-gen
        sudo update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
        ;;
    *)
        echo "Unsupported OS: $ID"
        return 1
        ;;
esac

# タイムゾーンの変更
sudo timedatectl set-timezone Asia/Tokyo
