#!/bin/bash
#
# Declare Variables
#
prodFolder=/homes/jpoland/images/phenocam/
echo $prodFolder
#
# Change to the phenocam incoming data directory
#
cd /homes/jpoland/images/staging
#
# Delete all temporary files created during pre-processing 
#
find . -name "GNSS*p1.txt"| xargs rm
find . -name "Img*p1.txt" | xargs rm
find . -name "Img*p2.txt" | xargs rm
find . -name "Img*p3.txt" | xargs rm
find . -maxdepth 1 -name "*.tar" | xargs rm
find . -maxdepth 1 -name "*md5.txt" | xargs rm
#
# Find the name of run directory containing all raw data (including renamed image files) and tar it 
# 
rawDataFolder=`find ./2* ! -name . -prune -type d` 
echo $rawDataFolder
runID=`find ./2* ! -name . -prune -type d|cut -c3-`
echo $runID
runName= pcam_$runID
echo $runName
tarFileName=$runName.tar
echo $tarFileName
tar -cvf $tarFileName $rawDataFolder
#
# Compute the checksum of the tar file containing the raw data
#
md5sum $tarFileName > $tarFileName.md5.txt
#
# Remove the raw data directory
#
rm -fr $rawDataFolder
#
# Move the tar file and md5 file to the production phenocam directory
#
mv $runName.* $prodFolder.
tarFileMD5=`md5sum $tarFileName|awk '{print $1}'`
echo $tarFileMD5
#
# Add record of run data into wheatgenetics run table
#
runID=`echo $runID`
startYear=`echo $runID|cut -c1-4`
startMonth=`echo $runID|cut -c5-6`
startDay=`echo $runID|cut -c7-8`
startDate=$startYear'-'$startMonth'-'$startDay
startHour=`echo $runID|cut -c10-11`
startMin=`echo $runID|cut -c12-13`
startSec=`echo $runID|cut -c14-15`
startTime=$startHour':'$startMin':'$startSec
endYear=`echo $runID|cut -c19-22`
endMonth=`echo $runID|cut -c23-24`
endDay=`echo $runID|cut -c25-26`
endDate=$endYear'-'$endMonth'-'$endDay
endHour=`echo $runID|cut -c28-29`
endMin=`echo $runID|cut -c30-31`
endSec=`echo $runID|cut -c32-33`
endTime=$endHour':'$endMin':'$endSec
runFileName=`echo $tarFileName`
#
# Build the Insert command for the run table
#
query="INSERT INTO phenocam_run (record_id,run_id,start_date,start_time,end_date,end_time,run_filename,md5sum) VALUES(0,'$runID','$startDate','$startTime','$endDate','$endTime','$runFileName','$tarFileMD5');"
echo $query
#
#

exit
