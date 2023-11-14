#!/bin/bash

# Check if a command exists
check_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install packages using the appropriate package manager
install_packages() {
    local package_manager

    if check_command_exists apt; then
        package_manager="apt"
    elif check_command_exists dnf; then
        package_manager="dnf"
    elif check_command_exists yum; then
        package_manager="yum"
    elif check_command_exists pacman; then
        package_manager="pacman"
    elif check_command_exists zypper; then
        package_manager="zypper"
    else
        echo "No supported package manager found."
        exit 1
    fi

    # Update and install packages
    "$package_manager" update
    "$package_manager" install -y "$@"
}

# Set environment variables
set_environments() {
    echo "SECRET_KEY_RW=\"$SECRET_KEY_RW\"" >> /etc/environment
    echo "SECRET_KEY_RO=\"$SECRET_KEY_RO\"" >> /etc/environment
}

# Download required assets
download_assets() {
    # Create directories
    mkdir -p /diphyx
    mkdir -p /volume

    # Download files
    curl -fsSL -o /diphyx/docker.sh https://get.docker.com
    curl -fsSL -o /diphyx/startup.sh https://raw.githubusercontent.com/diphyx/dxflow/main/startup.sh
    curl -fsSL -o /diphyx/disk.sh https://raw.githubusercontent.com/diphyx/dxflow/main/disk.sh
    curl -fsSL -o /diphyx/docker-compose.yaml https://raw.githubusercontent.com/diphyx/dxflow/main/docker-compose.yaml

    # Set execute permissions
    chmod +x /diphyx/docker.sh /diphyx/startup.sh /diphyx/disk.sh
}

# Install xfsprogs
install_xfsprogs() {
    install_packages xfsprogs
}

# Install Docker and configure user permissions
install_docker() {
    /bin/bash /diphyx/docker.sh
    groupadd docker
    usermod -aG docker "$USER"
    newgrp docker
}

# Mount storage device
mount_storage() {
    # Create mount directory
    mkdir -p /mnt/storage

    # Get all block devices and root device
    all_devices=$(lsblk -e 7 -r -d -p -n -o NAME)
    root_device=$(findmnt -n -o SOURCE / | head -n 1)

    # Find a non-root device and mount it
    for device in $all_devices; do
        if [ "$device" != "$root_device" ] && ! echo "$device" | grep -q "^${root_device%[0-9]*}"; then
            mkfs -t xfs "$device"
            mount "$device" /mnt/storage
            echo "$device /mnt/storage xfs defaults 0 2" >> /etc/fstab
            break
        fi
    done
}

# Main script execution
set_environments
download_assets
install_xfsprogs
install_docker
mount_storage