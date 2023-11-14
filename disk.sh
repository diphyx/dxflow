#!/bin/bash

# Resize the XFS file system on /mnt/storage
resize_disk() {
    xfs_growfs -d /mnt/storage
}

resize_disk
