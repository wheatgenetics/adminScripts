#!/bin/bash
# Description: Backup wheatgenetics mysql database
# Date: October 27,2014
# Updated: April 4,2019 to point to /bulk/mlucas/backup/wheatgenetics-database
#
NOW=$(date +"%Y%m%d")
echo $NOW
DEST="/bulk/mlucas/backup/wheatgenetics_database"
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
$MYSQLDUMP --single-transaction -u $MUSER -h $MHOST $MDB > $DBFILE 
$GZIP $DBFILE
#
exit
