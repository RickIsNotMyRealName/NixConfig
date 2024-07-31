#!/usr/bin/env nix-shell
#!nix-shell -i bash -p


# Function to elevate to root permissions
elevate_permissions() {
  sudo -v
}

# Function to get the device name using the PARTUUID
get_device_by_partuuid() {
  local partuuid=$1
  local device_name=$(blkid -t PARTUUID=$partuuid -o device)
  echo $device_name
}

# Function to mount the drive
mount_drive() {
  local partuuid="490a34b9-01"
  local current_user=$(whoami)
  local mount_point="/home/$current_user/mount/usb"

  # Get the device name
  elevate_permissions
  local device_name=$(get_device_by_partuuid $partuuid)

  if [ -z "$device_name" ]; then
    echo "Drive with PARTUUID $partuuid not found."
    exit 1
  fi

  # Check if the mount point exists; if not, create it
  if [ ! -d "$mount_point" ]; then
    sudo mkdir -p $mount_point
  fi

  # Mount the drive
  sudo mount $device_name $mount_point && echo "Drive mounted at $mount_point" || { echo "Failed to mount drive."; dmesg | tail; }
}

# Call the mount function
mount_drive
