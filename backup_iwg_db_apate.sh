#!/bin/bash
# Description: Backup intermediate_wheatgrass  mysql database
# Date: January 25,2017


#
NOW=$(date +"%Y%m%d")
echo $NOW
DEST="/bulk/mlucas/backup/iwg_database"
echo $DEST
#
# set mysql login info
#
MUSER="mlucas"               
MHOST="apate"
MDB="intermediate_wheatgrass"
#
# Find location of binaries needed
# 
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"
#
# Backup and compress wheatgenetics database
#
DBFILE=${DEST}/${MDB}_${NOW}_$(date +"%H%M").sql
echo $DBFILE
#
$MYSQLDUMP --single-transaction -u $MUSER -h $MHOST $MDB > $DBFILE 
$GZIP $DBFILE
#
exit
