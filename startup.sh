#!/bin/bash

# Write startup event
echo "$(date) | Startup" >> /volume/.events

# Start the DxFlow
if docker compose --file /diphyx/docker-compose.yaml up --force-recreate --detach; then
    echo "$(date) | DxFlow start successful" >> /volume/.events
else
    echo "$(date) | DxFlow start failed" >> /volume/.events
fi

# Listen to the FIFO
while true; do
    if read -r input < "/volume/.pipe"; then
        case $input in
        test)
                echo "$(date) | Pipe test" >> /volume/.events
            ;;
        expand_disk)
            if xfs_growfs -d /volume; then
                echo "$(date) | Disk expansion successful" >> /volume/.events
            else
                echo "$(date) | Disk expansion failed" >> /volume/.events
            fi
            ;;
        esac
    else
        echo "$(date) | Pipe error" >> /volume/.events
    fi
done
