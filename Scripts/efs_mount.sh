#!/bin/bash

EFS_ID="fs-0b0014dde61871822"
MOUNT_POINT="/mnt/efs"

echo "Creating mount directory..."
sudo mkdir -p $MOUNT_POINT

echo "Installing EFS utilities..."
sudo yum install -y amazon-efs-utils

echo "Mounting EFS..."
sudo mount -t efs ${EFS_ID}:/ $MOUNT_POINT

echo "Mounted successfully."

df -h