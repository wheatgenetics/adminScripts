#!/bin/bash
# Description: Backup wheatgenetics mysql database
# Date: October 27,2014
#
NOW=$(date +"%Y%m%d")
echo $NOW
DEST="/bulk/mlucas/backup/database"
echo $DEST
#
# set mysql login info
#
MUSER="mlucas"               
MHOST="apate"
MDB="wheatgenetics"
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
$MYSQLDUMP --single-transaction --hex-blob -u $MUSER -h $MHOST $MDB > $DBFILE 
$GZIP $DBFILE
#
exit
