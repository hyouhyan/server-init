#!/bin/bash

# Raspberry Pi固有設定モジュール

# LEDをオフにする（Debian/ラズパイのみ）
if [ "$ID" = "debian" ]; then
    BASE_URL="${BASE_URL:-https://raw.githubusercontent.com/hyouhyan/server-init/refs/heads/main}"
    curl -fsSL "${BASE_URL}/debian/init-raspi-led-off.sh" | sh
fi
