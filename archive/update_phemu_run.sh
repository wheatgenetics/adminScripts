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
runFileName='phemu_'$runID
mv $runFolder $runFileName
#
# Add record of run data into wheatgenetics run table
#
runID=`echo $runID`
latMIN=$(mysql wheatgenetics -h apate -u mlucas -ppassword -se "SELECT MIN(left_lat) FROM phemu_htp where run_id LIKE '$runID'")
latMAX=$(mysql wheatgenetics -h apate -u mlucas -ppassword -se "SELECT MAX(left_lat) FROM phemu_htp where run_id LIKE '$runID'")
longMIN=$(mysql wheatgenetics -h apate -u mlucas -ppassword -se "SELECT MIN(left_long) FROM phemu_htp where run_id LIKE '$runID'")
longMAX=$(mysql wheatgenetics -h apate -u mlucas -ppassword -se "SELECT MAX(left_long) FROM phemu_htp where run_id LIKE '$runID'")
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
