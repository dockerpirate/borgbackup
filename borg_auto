#!/bin/sh

## Variablen
USER=xy
SERVER=xy
REPOSITORY=xy

echo "###### Starting backup on $(date) ######"

## Datenbanken
## echo "Creating database dumps ..."
## /bin/bash /root/backup/dbdump.sh

echo "Schlüssel aktivieren"
export BORG_RSH='ssh -i /home/borg/.ssh/borgbackup'

echo "Start backup"
borg create -v -C lzma,9 --stats ssh://$USER@$SERVER:22//$REPOSITORY::'{now:%Y-%m-%d_%H:%M}' /backups

echo "###### Finished backup on $(date) ######"
