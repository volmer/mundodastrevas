#!/bin/bash

# Get remote backup

REMOTE_HOST="mundodastrevas.com"
REMOTE_USER="mundodastrevas"
REMOTE_BACKUP_DIR="/home/mundodastrevas/backups/mundodastrevas_backup"
LOCAL_BACKUP_DIR="/Users/volmer/backups"

echo "GET MUNDO DAS TREVAS BACKUP"
echo " "
echo "Start time: $(date)"

echo "Performing SCP to $REMOTE_HOST:$REMOTE_BACKUP_DIR"
scp -r $REMOTE_USER@$REMOTE_HOST:$REMOTE_BACKUP_DIR $LOCAL_BACKUP_DIR
echo "Backup data sucessfully copied to $LOCAL_BACKUP_DIR"
echo "End time: $(date)"
echo "Bye!"
echo " "
echo " "

exit 0
