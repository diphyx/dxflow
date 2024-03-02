#!/bin/bash

DX_PATH="/dx"
VOLUME_PATH="/volume"

LOG_FILE="$VOLUME_PATH/.dx/.events"
PIPE_FILE="$VOLUME_PATH/.dx/.pipe"

DOCKER_COMPOSE_FILE="$DX_PATH/docker-compose.yaml"

# a wrapper to log an event
log_event() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $*" >>"$LOG_FILE"
}

# a wrapper to execute a command and log the output
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

# starts the dxflow service
start_dxflow() {
    execute_command docker compose --progress quiet --file "$DOCKER_COMPOSE_FILE" up --quiet-pull --force-recreate --detach

    return $?
}

# stops the dxflow service
stop_dxflow() {
    execute_command docker compose --progress quiet --file "$DOCKER_COMPOSE_FILE" down

    return $?
}

# expands the volume disk
expand_disk() {
    execute_command xfs_growfs -d "$VOLUME_PATH"

    return $?
}

# processes the input from the pipe
process_pipe_input() {
    case $1 in
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
}

# startup
log_event ">> startup"

# run the dxflow service
if start_dxflow; then
    while true; do
        if read -r input <"$PIPE_FILE"; then
            process_pipe_input "$input"
        else
            log_event "<< pipe error, exit status: $?, PIPESTATUS: ${PIPESTATUS[*]}"
        fi
    done
fi
