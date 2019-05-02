#!/bin/bash
#
# Declare Variables
#
pcornProdFolder=/homes/jpoland/images/phenocorn/
echo $pcornProdFolder
#
# Change to the phenocam incoming data directory
#
cd /homes/jpoland/images/staging/
echo 'Working Directory:'
pwd
#
# Delete all temporary files created during pre-processing 
#
runFolder=`find -maxdepth 1 -name "2*" -type d`
echo 'Run Folder:'$runFolder
cd $runFolder
pwd
find . -maxdepth 1 -name "*IRT.txt"| xargs rm
find . -maxdepth 1 -name "*NDVI.txt"| xargs rm
find . -maxdepth 1 -name "*Video.txt"| xargs rm
#
# Delete the tar file containing the raw data and the accompanyimg md5 file
#
cd ..
find . -maxdepth 1 -name "*.tar"| xargs rm
find . -maxdepth 1 -name "*_md5.txt"| xargs rm
#
# tar all raw data in the run directory 
# 
#runFolder=`find -maxdepth 1 -name "2*" -type d`
#echo $runFolder
runID=`find -maxdepth 1 -name "2*" -type d|cut -c3-`
echo 'Run ID: '$runID
tarFileName='pcorn_'$runID.tar
echo 'Tar File Name: ',$tarFileName
tar -cvf $tarFileName $runFolder
#
# Remove the runID data directory
#
rm -fr $runFolder
#
# Move the tar file and md5 file to the production phenocam directory
#
tarFileMD5=`md5sum $tarFileName|awk '{print $1}'`
echo 'Tar File MD5: '$tarFileMD5
chmod u-w $tarFileName
chgrp ksu-plantpath-jpoland $tarFileName
mv $tarFileName $pcornProdFolder.
#
# Add record of run data into wheatgenetics run table
#
runID=`echo $runID`
echo 'The run ID is ',$runID
startYear=`echo $runID|cut -c1-4`
startMonth=`echo $runID|cut -c5-6`
startDay=`echo $runID|cut -c7-8`
startDate=$startYear'-'$startMonth'-'$startDay
startHour=`echo $runID|cut -c10-11`
startMin=`echo $runID|cut -c12-13`
startSec=`echo $runID|cut -c14-15`
startTime=$startHour':'$startMin':'$startSec
endYear=`echo $runID|cut -c17-20`
endMonth=`echo $runID|cut -c21-22`
endDay=`echo $runID|cut -c23-24`
endDate=$endYear'-'$endMonth'-'$endDay
endHour=`echo $runID|cut -c26-27`
endMin=`echo $runID|cut -c28-29`
endSec=`echo $runID|cut -c30-31`
endTime=$endHour':'$endMin':'$endSec
runFileName=`echo $tarFileName`
latMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(left_lat) FROM phenocorn_htp where run_id LIKE '$runID'")
latMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(left_lat) FROM phenocorn_htp where run_id LIKE '$runID'")
longMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(left_long) FROM phenocorn_htp where run_id LIKE '$runID'")
longMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(left_long) FROM phenocorn_htp where run_id LIKE '$runID'")
echo $latMIN
echo $latMAX
echo $longMIN
echo $longMAX
#
query="INSERT INTO phenocorn_run (record_id,run_id,start_date,start_time,end_date,end_time,run_filename,md5sum,lat_min,lat_max,long_min,long_max) VALUES(0,'$runID','$startDate','$startTime','$endDate','$endTime','$runFileName','$tarFileMD5','$latMIN','$latMAX','$longMIN','$longMAX');"
echo $query
#TBD
#
exit
