#!/bin/bash

# Write startup event
echo "$(date) | startup" >> /volume/.dx/.events

# Start the dxflow
if docker compose --file /dx/docker-compose.yaml up --force-recreate --detach; then
    echo "$(date) | dxflow start successful" >> /volume/.dx/.events
else
    echo "$(date) | dxflow start failed" >> /volume/.dx/.events
fi

# Listen to the FIFO
while true; do
    if read -r input < "/volume/.dx/.pipe"; then
        case $input in
        test)
                echo "$(date) | pipe test" >> /volume/.dx/.events
            ;;
        restart_dxflow)
            if docker compose --file /dx/docker-compose.yaml down; then
                echo "$(date) | dxflow stop successful" >> /volume/.dx/.events

                if docker compose --file /dx/docker-compose.yaml up --detach; then
                    echo "$(date) | dxflow restart successful" >> /volume/.dx/.events
                else
                    echo "$(date) | dxflow restart failed" >> /volume/.dx/.events
                fi
            else
                echo "$(date) | dxflow stop failed" >> /volume/.dx/.events
            fi
            ;;
        expand_disk)
            if xfs_growfs -d /volume; then
                echo "$(date) | disk expansion successful" >> /volume/.dx/.events
            else
                echo "$(date) | disk expansion failed" >> /volume/.dx/.events
            fi
            ;;
        esac
    else
        echo "$(date) | pipe error" >> /volume/.dx/.events
    fi
done
