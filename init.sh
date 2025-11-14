#!/bin/bash

. /etc/os-release

if [ "$ID" = "ubuntu" ]; then
    sh init-ubuntu-server.sh
elif [ "$ID" = "debian" ]; then
    sh init-debian-server.sh
else
    echo "unsupported: $ID"
fi
