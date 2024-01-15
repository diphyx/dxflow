#!/bin/bash

# Write startup event
echo "$(date) | Startup" >> /volume/.dx/.events

# Start the DxFlow
if docker compose --file /dx/docker-compose.yaml up --force-recreate --detach; then
    echo "$(date) | DxFlow start successful" >> /volume/.dx/.events
else
    echo "$(date) | DxFlow start failed" >> /volume/.dx/.events
fi

# Listen to the FIFO
while true; do
    if read -r input < "/volume/.dx/.pipe"; then
        case $input in
        test)
                echo "$(date) | Pipe test" >> /volume/.dx/.events
            ;;
        expand_disk)
            if xfs_growfs -d /volume; then
                echo "$(date) | Disk expansion successful" >> /volume/.dx/.events
            else
                echo "$(date) | Disk expansion failed" >> /volume/.dx/.events
            fi
            ;;
        esac
    else
        echo "$(date) | Pipe error" >> /volume/.dx/.events
    fi
done
