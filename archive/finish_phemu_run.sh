#!/bin/bash
#
# Prompt user for the run ID
#
echo Enter Start Date:
read startDate
echo Enter Start Time:
read startTime
echo Enter End Date:
read endDate
echo Enter End Time:
read endTime
runID=$startDate'_'$startTime'_'$endDate'_'$endTime
echo "Run ID is "$runID
#
#
# Declare Variables
#
phemuProdFolder=/homes/jpoland/images/phemu/
echo "phemu production folder is "$phemuProdFolder
#
# Change to the phemu incoming data directory
#
stagingFolder=/homes/jpoland/images/staging/
echo "Staging Folder is "$stagingFolder
cd $stagingFolder
echo "Working Directory:"
pwd
runFolder=`find -maxdepth 1 -name "phemu_2*" -type d`
echo "Phemu Run Folder is "$runFolder
cd $runFolder
echo "Working Directory:"
pwd
#
# Delete temporary files created during pre-processingi
# Retain sensor p3 files and image p4 files as requested by Kevin

find . -maxdepth 1 -name "*p1.txt"| xargs rm
find . -maxdepth 1 -name "*p2.txt"| xargs rm
find . -maxdepth 1 -name "*Img*p3.txt"| xargs rm
#find . -maxdepth 1 -name "*p3.txt"| xargs rm
#find . -maxdepth 1 -name "*p4.txt"| xargs rm
#
# Change permissions and group on the run directory and rename with run_id
#
cd ..
runFileName='phemu_'$runID
mv $runFolder $runFileName
#chmod -R u-w $runFileName
#chgrp -R ksu-plantpath-jpoland $runFileName
mv $runFileName $phemuProdFolder.
#
# Add record of run data into wheatgenetics run table
#
runID=`echo $runID`
latMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(left_lat) FROM phemu_htp where run_id LIKE '$runID'")
latMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(left_lat) FROM phemu_htp where run_id LIKE '$runID'")
longMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(left_long) FROM phemu_htp where run_id LIKE '$runID'")
longMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(left_long) FROM phemu_htp where run_id LIKE '$runID'")
echo $latMIN
echo $latMAX
echo $longMIN
echo $longMAX
#
query="INSERT INTO phemu_run (record_id,run_id,start_date,start_time_utc,end_date,end_time_utc,run_folder_name,lat_min,lat_max,long_min,long_max) VALUES(0,'$runID','$startDate','$startTime','$endDate','$endTime','$runFileName','$latMIN','$latMAX','$longMIN','$longMAX');"
echo $query
#
#
exit
