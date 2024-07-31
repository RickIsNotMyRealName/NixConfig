#! /usr/bin/env nix-shell
#! nix-shell -i bash -p dmidecode

# Prompt for sudo
sudo echo "Prompting for sudo to get host information..."


# Print host information
echo "BIOS information:"
sudo dmidecode --type bios
echo "--------------------------------------------------"

echo "System information:"
sudo dmidecode --type system
echo "--------------------------------------------------"

echo "Baseboard information:"
sudo dmidecode --type baseboard
echo "--------------------------------------------------"

echo "Chassis information:"
sudo dmidecode --type chassis
echo "--------------------------------------------------"

echo "Processor information:"
sudo dmidecode --type processor
echo "--------------------------------------------------"

echo "Memory information:"
sudo dmidecode --type memory
echo "--------------------------------------------------"

# oemStrings
echo "OEM Strings:"
sudo dmidecode --type 11
echo "--------------------------------------------------"