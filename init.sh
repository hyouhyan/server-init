#!/bin/bash

# Server initialization script

## Setup
BASE_URL="https://raw.githubusercontent.com/hyouhyan/server-init/refs/heads/main"
export BASE_URL

. /etc/os-release

## Check OS support
case "$ID" in
    ubuntu|debian)
        ;;
    *)
        echo "Unsupported OS: $ID"
        exit 1
        ;;
esac

## Update package list
sudo apt-get update

## Run modules
run_module() {
    local module="$1"
    echo "Running module: $module..."
    curl -fsSL "${BASE_URL}/modules/${module}/init.sh" | sh
    if [ $? -ne 0 ]; then
        echo "Failed to run module: $module"
        return 1
    fi
}

run_module "locale"
run_module "docker"
run_module "vpn"
run_module "maintenance"
run_module "raspi"

echo "Server initialization completed!"
