#!/bin/bash

# Main paths
DX_PATH="/dx"
VOLUME_PATH="/volume"

# Startup script file
STARTUP_SCRIPT_FILE="$DX_PATH/script.sh"

# Docker compose file
DOCKER_COMPOSE_FILE="$DX_PATH/docker-compose.yaml"

# Necessary files
PIPE_FILE="$VOLUME_PATH/.dx/.pipe"
LOG_FILE="$VOLUME_PATH/.dx/.events"
STATS_FILE="$VOLUME_PATH/.dx/.stats"

# A wrapper to log an event
log_event() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $*" >>"$LOG_FILE"
}

# A wrapper to execute a command and log the output
execute_command() {
    log_event ">> $*"

    output=$("$@" 2>&1)
    status=$?
    if [ $status -eq 0 ]; then
        log_event "<< successful"
    else
        log_event "<< $output"
    fi

    return $status
}

# Starts the dxflow service
start_dxflow() {
    execute_command docker compose --progress quiet --file "$DOCKER_COMPOSE_FILE" up --quiet-pull --force-recreate --detach

    return $?
}

# Stops the dxflow service
stop_dxflow() {
    execute_command docker compose --progress quiet --file "$DOCKER_COMPOSE_FILE" down

    return $?
}

# Expands the volume disk
expand_disk() {
    execute_command xfs_growfs -d "$VOLUME_PATH"

    return $?
}

# Reads the pipe
read_pipe() {
    while true; do
        if read -r input <"$PIPE_FILE"; then
            case $input in
            test)
                log_event "<< pipe test"
                ;;
            restart_dxflow)
                log_event "<< pipe restart_dxflow"

                if stop_dxflow; then
                    start_dxflow
                fi
                ;;
            expand_disk)
                log_event "<< pipe expand_disk"

                expand_disk
                ;;
            *)
                log_event "<< pipe $1"
                ;;
            esac
        else
            log_event "<< pipe error, exit status: $?, PIPESTATUS: ${PIPESTATUS[*]}"
        fi
    done
}

# Writes the system statistics
write_stats() {
    while true; do
        # Get CPU usage
        CPU=$(vmstat -wn | tail -1 | awk '{print 100 - $15}')

        # Get memory usage
        MEMORY=$(awk "BEGIN {printf \"%d\", ($(vmstat -s | awk 'NR==2 {print $1}') / $(vmstat -s | awk 'NR==1 {print $1}')) * 100}")

        # Get disk usage
        BOOT_DISK=$(df -hT | awk '$7 ~ /^\/$/ {print $6}' | sed 's/%//')
        VOLUME_DISK=$(df -hT | awk '$7 ~ /^\/volume$/ {print $6}' | sed 's/%//')

        # Write the statistics
        echo "$CPU,$MEMORY,$BOOT_DISK,$VOLUME_DISK" > "$STATS_FILE"

        sleep 5
    done
}

# Startup
log_event ">> startup"

# Execute the startup script
if [ -e "$STARTUP_SCRIPT_FILE" ]; then
    execute_command sh "$STARTUP_SCRIPT_FILE"
fi

# Run the dxflow service
if start_dxflow; then
    read_pipe &
    write_stats &

    wait
fi
