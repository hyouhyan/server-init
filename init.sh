#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/hyouhyan/server-init/refs/heads/main/"
CURL_COMMAND="curl -fsSL"

. /etc/os-release

if [ "$ID" = "ubuntu" ]; then
    $CURL_COMMAND "${BASE_URL}init-ubuntu-server.sh" | sh
elif [ "$ID" = "debian" ]; then
    $CURL_COMMAND "${BASE_URL}init-debian-server.sh" | sh
else
    echo "unsupported: $ID"
fi
