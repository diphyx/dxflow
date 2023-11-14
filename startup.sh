#!/bin/bash

# Add startup log
write_log() {
    date >> /mnt/storage/.startup
}

write_log
