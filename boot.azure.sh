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

# Send compute unit event
send_compute_unit_events() {
    # Init URL
    url="http://diphyx.com/api/compute/units/${DXO_COMPUTE_UNIT_POINTER}/events/?secret-key=${DXO_COMPUTE_UNIT_SECRET_KEY_RW}"

    # Send request
    curl -X PUT -H "Content-Type: application/json" -d "{\"type\": \"$1\", \"message\": \"$2\"}" "${url}" --connect-timeout 3 || true
}

# Add authorized key
add_authorized_key() {
    # Define the home directory
    home_dir="/home/$1"

    # Return if the home directory doesn't exist
    if [ ! -d "$home_dir" ]; then
        return
    fi

    # Define the .ssh directory
    ssh_dir="$home_dir/.ssh"

    # Create the .ssh directory if it doesn't exist
    if [ ! -d "$ssh_dir" ]; then
        mkdir -p "$ssh_dir"
        chown "$1:$1" "$ssh_dir"
        chmod 700 "$ssh_dir"
    fi

    # Define the authorized_keys file
    authorized_keys_file="$ssh_dir/authorized_keys"

    # Create the authorized_keys file if it doesn't exist
    if [ ! -f "$authorized_keys_file" ]; then
        touch "$authorized_keys_file"
        chown "$1:$1" "$authorized_keys_file"
        chmod 600 "$authorized_keys_file"
    fi

    # Add the key if it doesn't exist
    if ! grep -q "$2" "$authorized_keys_file"; then
        echo "$2" >> "$authorized_keys_file"
        chown "$1:$1" "$authorized_keys_file"
    fi
}

# Send compute unit event
send_compute_unit_events "INFO" "booting"

# Set environment variables
{
    echo "DXO_COMPUTE_UNIT_POINTER=\"$DXO_COMPUTE_UNIT_POINTER\""
    echo "DXO_COMPUTE_UNIT_SECRET_KEY_RW=\"$DXO_COMPUTE_UNIT_SECRET_KEY_RW\""
    echo "DXO_COMPUTE_UNIT_SECRET_KEY_RO=\"$DXO_COMPUTE_UNIT_SECRET_KEY_RO\""
    echo "DXO_COMPUTE_UNIT_EXTENSIONS=\"$DXO_COMPUTE_UNIT_EXTENSIONS\""
} >> /etc/environment

# Initialize authorized keys
authorized_keys=$(echo "$DXO_AUTHORIZED_KEYS" | tr "," "\n")
for authorized_key in "$authorized_keys"; do
    # List all users
    users=$(awk -F: '/\/home/ {print $1}' /etc/passwd)

    # Add the authorized key to users
    for user in $users; do
        add_authorized_key "$user" "$authorized_key"
    done
done

# Create dx directory
mkdir /dx

# Download files
curl -fsSL -o /dx/docker.sh https://get.docker.com
curl -fsSL -o /dx/startup.sh https://raw.githubusercontent.com/diphyx/dxflow/main/startup.sh
curl -fsSL -o /dx/docker-compose.yaml https://raw.githubusercontent.com/diphyx/dxflow/main/docker-compose.yaml

# Set execute permissions
chmod +x /dx/docker.sh /dx/startup.sh

# Send compute unit event
send_compute_unit_events "INFO" "installing"

# Install xfsprogs
install_packages xfsprogs

# Install Docker
/bin/bash /dx/docker.sh

# Create mount directory
mkdir /volume

# Format and mount disk
mkfs -t xfs /dev/sdc
mount /dev/sdc /volume
echo "/dev/sdc /volume xfs defaults 0 2" >> /etc/fstab

# Initialize crontab
echo "@reboot /dx/startup.sh" | crontab -

# Initialize named pipe
mkdir -p /volume/.dx
mkfifo /volume/.dx/.pipe

# Send compute unit event
send_compute_unit_events "INFO" "starting"

# Run startup script
/bin/bash /dx/startup.sh
