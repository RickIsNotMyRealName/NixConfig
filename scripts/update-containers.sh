#!/bin/bash

echo "----------------------------------------------------"

# Remove /root/NixConfig
rm -rf /root/NixConfig

# Clone the repository
git clone https://github.com/RickIsNotMyRealName/NixConfig /root/NixConfig
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

# Change to the NixConfig directory
cd /root/NixConfig
if [ $? -ne 0 ]; then
    echo "Error: Failed to change directory to /root/NixConfig."
    exit 1
fi

# Rebuild NixOS
nixos-rebuild boot --flake '.#'
if [ $? -ne 0 ]; then
    echo "Error: nixos-rebuild failed."
    exit 1
fi

# Reboot the system
reboot