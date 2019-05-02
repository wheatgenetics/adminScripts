#!/bin/bash
# Description: Backup wgrc mysql database
# Date: February 4,2016
# Updated: April 15,2019 Changed path to /bulk/mlucas/backup/wgrc_database
#
NOW=$(date +"%Y%m%d")
echo $NOW
DEST="/bulk/mlucas/backup/wgrc_database"
echo $DEST
#
# set mysql login info
#
MUSER="mlucas"               
MHOST="apate"
MDB="wgrc"
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
