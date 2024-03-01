#!/bin/bash

# Write startup event
echo "$(date) | startup" >> /volume/.dx/.events

# Start the dxflow
startError=$(docker compose --file /dx/docker-compose.yaml up --force-recreate --detach 2>&1 >/dev/null)
if [ -z "$startError" ]; then
    echo "$(date) | dxflow start successful" >> /volume/.dx/.events
else
    echo "$(date) | dxflow start failed: $startError" >> /volume/.dx/.events
fi

# Listen to the FIFO
while true; do
    if read -r input < "/volume/.dx/.pipe"; then
        case $input in
        test)
                echo "$(date) | pipe test" >> /volume/.dx/.events
            ;;
        restart_dxflow)
            stopError=$(docker compose --file /dx/docker-compose.yaml down 2>&1 >/dev/null)
             if [ -z "$stopError" ]; then
                echo "$(date) | dxflow stop successful" >> /volume/.dx/.events

                restartError=$(docker compose --file /dx/docker-compose.yaml down 2>&1 >/dev/null)
                if [ -z "$restartError" ]; then
                    echo "$(date) | dxflow restart successful" >> /volume/.dx/.events
                else
                    echo "$(date) | dxflow restart failed: $restartError" >> /volume/.dx/.events
                fi
            else
                echo "$(date) | dxflow stop failed: $stopError" >> /volume/.dx/.events
            fi
            ;;
        expand_disk)
            expandDiskError=$(xfs_growfs -d /volume 2>&1 >/dev/null)
            if [ -z "$expandDiskError" ]; then
                echo "$(date) | disk expansion successful" >> /volume/.dx/.events
            else
                echo "$(date) | disk expansion failed: $expandDiskError" >> /volume/.dx/.events
            fi
            ;;
        esac
    else
        echo "$(date) | pipe error" >> /volume/.dx/.events
    fi
done
