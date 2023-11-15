#!/bin/bash

# Write startup log
write_log() {
    echo "$(date) | Startup" >> /volume/.log
}

# Start the DxFlow
start_dxflow() {
    if docker compose --file /diphyx/docker-compose.yaml up --detach; then
        echo "$(date) | DxFlow start successful" >> /volume/.log
    else
        echo "$(date) | DxFlow start failed" >> /volume/.log
    fi
}

# Listen to the FIFO
listen_to_pipe() {
    while true; do
        if read -r input < "/volume/.pipe"; then
            case $input in
            test)
                 echo "$(date) | Pipe test" >> /volume/.log
                ;;
            expand_disk)
                if xfs_growfs -d /volume; then
                    echo "$(date) | Disk expansion successful" >> /volume/.log
                else
                    echo "$(date) | Disk expansion failed" >> /volume/.log
                fi
                ;;
            esac
        else
            echo "$(date) | Pipe error" >> /volume/.log
        fi
    done
}



# Write startup log
write_log

# Start the DxFlow
start_dxflow

# Listen to the FIFO
listen_to_pipe
