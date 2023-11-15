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
        exit 1
    fi

    # Update and install packages
    "$package_manager" update
    "$package_manager" install -y "$@"
}

# Send compute unit log
compute_unit_log() {
    # Init URL
    url="${DXO_ENDPOINT}/compute/units/${DXO_COMPUTE_UNIT_POINTER}/logs/"

    # Send request
    curl -X PUT -H "Content-Type: application/json" -d "{\"type\": \"$1\", \"message\": \"$2\"}" "${url}" || true
}

# Send compute unit log
compute_unit_log "INFO" "booting"

# Set environment variables
echo "DXO_ENDPOINT=\"$DXO_ENDPOINT\"" >> /etc/environment
echo "DXO_ZERO_KEY=\"$DXO_ZERO_KEY\"" >> /etc/environment
echo "DXO_COMPUTE_UNIT_POINTER=\"$DXO_COMPUTE_UNIT_POINTER\"" >> /etc/environment
echo "DXO_COMPUTE_UNIT_SECRET_KEY_RW=\"$DXO_COMPUTE_UNIT_SECRET_KEY_RW\"" >> /etc/environment
echo "DXO_COMPUTE_UNIT_SECRET_KEY_RO=\"$DXO_COMPUTE_UNIT_SECRET_KEY_RO\"" >> /etc/environment

# Create diphyx directory
mkdir -p /diphyx

# Download files
curl -fsSL -o /diphyx/docker.sh https://get.docker.com
curl -fsSL -o /diphyx/startup.sh https://raw.githubusercontent.com/diphyx/dxflow/main/startup.sh
curl -fsSL -o /diphyx/docker-compose.yaml https://raw.githubusercontent.com/diphyx/dxflow/main/docker-compose.yaml

# Set execute permissions
chmod +x /diphyx/docker.sh /diphyx/startup.sh

# Send compute unit log
compute_unit_log "INFO" "installing"

# Install xfsprogs
install_packages xfsprogs

# Install Docker
/bin/bash /diphyx/docker.sh

# Create mount directory
mkdir /volume

# Get all block devices and root device
all_disk_devices=$(lsblk -e 7 -r -d -p -n -o NAME)
root_disk_device=$(findmnt -n -o SOURCE / | head -n 1)

# Find a non-root device and mount it
for disk_device in $all_disk_devices; do
    if [ "$disk_device" != "$root_disk_device" ] && ! echo "$disk_device" | grep -q "^${root_disk_device%[0-9]*}"; then
        mkfs -t xfs "$disk_device"
        mount "$disk_device" /volume
        echo "$disk_device /volume xfs defaults 0 2" >> /etc/fstab
        
        break
    fi
done

# Initialize crontab
echo "@reboot /diphyx/startup.sh" | crontab -

# Initialize named pipe
mkfifo /volume/.pipe

# Send compute unit log
compute_unit_log "INFO" "starting"

# Run startup script
/bin/bash /diphyx/startup.sh