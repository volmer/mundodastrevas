#!/bin/bash

# Script de Backup para Mundo das Trevas

DATEF=$(date +"%F")
PUBLIC_DIR="/home/mundodastrevas/mundodastrevas/shared/public/"
BACKUP_DIR="/home/mundodastrevas/mundodastrevas_backup"
DUMP_FILENAME="mundodastrevas_$DATEF.dump"
DB_NAME="mundodastrevas_production"
PGPASSWORD="mundodastrevas"
PG_USERNAME="mundodastrevas"
PUBLIC_BACKUP_NAME="public_$DATEF.tar.gz"

echo "MUNDO DAS TREVAS BACKUP"
echo " "
echo "Public dir: $PUBLIC_DIR"
echo "Start time: $(date)"

rm $BACKUP_DIR/*
PGPASSWORD=$PGPASSWORD pg_dump --username=$PG_USERNAME --format=custom $DB_NAME > $BACKUP_DIR/$DUMP_FILENAME
tar -zcf $BACKUP_DIR/$PUBLIC_BACKUP_NAME $PUBLIC_DIR

echo "Backup finished at $(date)"
echo "Bye!"
echo " "
echo " "

exit 0
