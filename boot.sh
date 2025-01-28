#!/bin/bash

# Check if a command exists
check_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

send_compute_unit_events() {
    # Define the URL
    url="http://diphyx.com/api/compute/units/${DXO_COMPUTE_UNIT_POINTER}/events/?secret-key=${DXO_COMPUTE_UNIT_SECRET_KEY_RW}"

    # Send request
    if check_command_exists curl; then
        curl -X PUT -H "Content-Type: application/json" -d "{\"type\": \"$1\", \"message\": \"$2\"}" "${url}" --connect-timeout 3 || true
    elif check_command_exists wget; then
        wget -q --method=PUT --header="Content-Type: application/json" --body-data "{\"type\": \"$1\", \"message\": \"$2\"}" "${url}" --timeout=3 || true
    fi
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
        send_compute_unit_events "ERROR" "unhandled package manager"

        exit 1
    fi

    # Check if the package is installed
    if dpkg -l | grep -q "$1"; then
        return 0
    fi

    # Update and install packages
    "$package_manager" update
    "$package_manager" install -y "$@"
}

# Add authorized key
add_authorized_key() {
    # Define the home directory
    home_dir="/home/$1"

    # Check if the home directory exists
    if [ ! -d "$home_dir" ]; then
        return 1
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

# Download nessessary file
download_necessary_file() {
    local file_path
    local file_url

    if [ "$1" = "docker" ]; then
        file_path="/dx/docker.sh"
        file_url="https://get.docker.com"
    elif [ "$1" = "startup" ]; then
        file_path="/dx/startup.sh"
        file_url="https://raw.githubusercontent.com/diphyx/dxflow/main/startup.sh"
    elif [ "$1" = "compose" ]; then
        file_path="/dx/docker-compose.yaml"
        file_url="https://raw.githubusercontent.com/diphyx/dxflow/main/docker-compose.yaml"
    else
        return 1
    fi

    # Download the file
    if check_command_exists curl; then
        curl -fsSL -o "${file_path}" "${file_url}"
    elif check_command_exists wget; then
        wget -q -O "${file_path}" "${file_url}"
    fi
}

# Download startup file
download_startup_file() {
    local file_path

    if [ "$1" = "variables" ]; then
        file_path="/dx/variables.env"
    elif [ "$1" = "packages" ]; then
        file_path="/dx/packages.txt"
    elif [ "$1" = "script" ]; then
            file_path="/dx/script.sh"
    elif [ "$1" = "flow" ]; then
        file_path="/dx/flow.yaml"
    else
        return 1
    fi

    # Define the URL
    file_url="http://diphyx.com/api/compute/units/${DXO_COMPUTE_UNIT_POINTER}/startup/$1/?secret-key=${DXO_COMPUTE_UNIT_SECRET_KEY_RO}"

    # Download the file
    if check_command_exists curl; then
        curl -fsSL -o "${file_path}" "${file_url}"
    elif check_command_exists wget; then
        wget -q -O "${file_path}" "${file_url}"
    fi
}

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

send_compute_unit_events "INFO" "downloading necessary files"

# Download necessary files
download_necessary_file "docker"
download_necessary_file "startup"
download_necessary_file "compose"

send_compute_unit_events "INFO" "downloading startup files"

# Download startup files
download_startup_file "variables"
download_startup_file "packages"
download_startup_file "script"
download_startup_file "flow"

# Set startup variables
if [ -e /dx/variables.env ]; then
    while IFS= read -r line; do
        export "$line"
        echo "$line" >> /etc/environment
    done < /dx/variables.env
fi

# Check if docker.sh exists
if [ ! -e /dx/docker.sh ]; then
    send_compute_unit_events "ERROR" "cannot find docker.sh"

    exit 1
fi

# Set execute permissions
chmod +x /dx/docker.sh

send_compute_unit_events "INFO" "installing docker"

# Install Docker
if ! check_command_exists docker; then
    /bin/bash /dx/docker.sh
fi

send_compute_unit_events "INFO" "installing dependencies"

# Install dependencies
install_packages xfsprogs sysstat

# Install startup packages
if [ -e /dx/packages.txt ]; then
    send_compute_unit_events "INFO" "installing startup packages"

    while IFS=, read -r package; do
        install_packages "$package"
    done < /dx/packages.txt
fi

send_compute_unit_events "INFO" "pulling dxflow core"

# Pull dxflow core
docker pull dxflow/redis
docker pull dxflow/alpine
docker pull dxflow/syslog
docker pull dxflow/api

send_compute_unit_events "INFO" "pulling dxflow extensions"

# Pull dxflow extensions
dxflow_extensions=$(echo "$DXO_COMPUTE_UNIT_EXTENSIONS" | tr "," "\n")
for dxflow_extension in "$dxflow_extensions"; do
    docker pull "dxflow/ext-$dxflow_extension"
done

send_compute_unit_events "INFO" "preparing"

# Create volume
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

# Check if startup.sh exists
if [ ! -e /dx/startup.sh ]; then
    send_compute_unit_events "ERROR" "cannot find startup.sh"

    exit 1
fi

# Set execute permissions
chmod +x /dx/startup.sh

# Initialize crontab
echo "@reboot /dx/startup.sh" | crontab -

# Initialize named pipe
mkdir -p /volume/.dx
mkfifo /volume/.dx/.pipe

send_compute_unit_events "INFO" "starting"

# Run startup script
/bin/bash /dx/startup.sh &
