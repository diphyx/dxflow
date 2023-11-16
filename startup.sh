#!/bin/bash

# Write startup log
echo "$(date) | Startup" >> /volume/.log

# Start the DxFlow
if docker compose --file /diphyx/docker-compose.yaml up --force-recreate --detach; then
    echo "$(date) | DxFlow start successful" >> /volume/.log
else
    echo "$(date) | DxFlow start failed" >> /volume/.log
fi

# Listen to the FIFO
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
