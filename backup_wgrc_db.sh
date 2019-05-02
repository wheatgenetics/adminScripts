#!/bin/sh
cd /var/services/homes/mlucas
ssh mlucas@129.130.32.11 'bash -s' < backup_wgrc_db_apate.sh
rsync -e ssh --ignore-existing -av mlucas@129.130.32.11:/bulk/mlucas/backup/wgrc_database/*.gz dbBackup
ssh mlucas@129.130.32.11 find /bulk/mlucas/backup/wgrc_database -maxdepth 1 -type f -mtime +90 -delete -print
exit
