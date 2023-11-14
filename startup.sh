#!/bin/bash

# Write startup log
write_log() {
    date >> /volume/.startup.log
}

# Listen to the FIFO
listen_to_pipe() {
    while true; do
        if read -r input < "/volume/.pipe"; then
            case $input in
            log)
                date >> /volume/.pipe.log
                ;;
            expand_disk)
                xfs_growfs -d /volume
                ;;
            esac
        fi
    done
}

# Write startup log
write_log

# Listen to the FIFO
listen_to_pipe
