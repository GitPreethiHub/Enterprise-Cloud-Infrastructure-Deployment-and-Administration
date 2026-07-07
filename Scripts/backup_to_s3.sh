#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)

cp /var/www/html/index.html backup-$DATE.html

aws s3 cp backup-$DATE.html s3://preethi-aegis-backups-2026/

echo "Backup completed at $(date)"
