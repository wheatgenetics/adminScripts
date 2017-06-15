#!/bin/bash
#
# Declare Variables
#
uasProdFolder=/bulk/jpoland/images/uas/
echo $uasProdFolder
#
# Change to the phenocam incoming data directory
#
cd /bulk/jpoland/images/staging/
pwd
#
# Get Flight Information
#
flightPath=`find -maxdepth 1 -name "uas_2*" -type d`
echo $flightPath
flightFolder=`find -maxdepth 1 -name "uas_2*" -type d`
echo $flightFolder
flightID=`find -maxdepth 1 -name "uas_2*" -type d|cut -c3-`
echo $flightID
#
# Get Camera Serial Number from operator log for uas_run table entry
#
#cameraID='CAM_'`grep "Camera serial#: " $flightPath/Drone*.txt | cut -c19-`
cameraID='CAM_'`grep "Camera serial#," $flightPath/Drone*.txt | cut -c16-`
echo "Camera ID: "$cameraID
#
# Get planned flight elevation from operator log
#
#elevation=`grep "Flight elevation (ft):" $flightPath/Drone*.txt | cut -c25-26`
elevation=`grep "Flight elevation(m)," $flightPath/Drone*.txt | cut -c21-22`
echo $elevation
#
# Delete all temporary files created during pre-processing 
#
find $flightFolder -name "uas_metadata*"| xargs rm
#
# Delete the tar file containing the raw data and the accompanyimg md5 file
#
find . -maxdepth 1 -name "uas*.tar.gz"| xargs rm
find . -maxdepth 1 -name "uas*.zip"| xargs rm
find . -maxdepth 1 -name "uas*_md5.txt"| xargs rm
#
# Tar the run directory containing all raw data (including renamed image files)
# 
tarFileName=$flightID.tar
echo $tarFileName
tar -cvf $tarFileName $flightFolder
#
# Remove the flightID data directory
#
rm -fr $flightFolder
#
# Move the tar file and md5 file to the production phenocam directory
#
tarFileMD5=`md5sum $tarFileName|awk '{print $1}'`
echo $tarFileMD5
chmod u-w $tarFileName
chgrp ksu-plantpath-jpoland $tarFileName
mv $tarFileName $uasProdFolder.
#
# Add record of run data into wheatgenetics run table
#
runID=`echo $flightID`
startYear=`echo $flightID|cut -c5-8`
startMonth=`echo $flightID|cut -c9-10`
startDay=`echo $flightID|cut -c11-12`
startDate=$startYear'-'$startMonth'-'$startDay
startHour=`echo $flightID|cut -c14-15`
startMin=`echo $flightID|cut -c16-17`
startSec=`echo $flightID|cut -c18-19`
startTime=$startHour':'$startMin':'$startSec
endYear=`echo $flightID|cut -c21-24`
endMonth=`echo $flightID|cut -c25-26`
endDay=`echo $flightID|cut -c27-28`
endDate=$endYear'-'$endMonth'-'$endDay
endHour=`echo $flightID|cut -c30-31`
endMin=`echo $flightID|cut -c32-33`
endSec=`echo $flightID|cut -c34-35`
endTime=$endHour':'$endMin':'$endSec
flightFileName=`echo $tarFileName`
latMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(cam_latitude) FROM uas_images where flight_id LIKE '$flightID'")
latMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(cam_latitude) FROM uas_images where flight_id LIKE '$flightID'")
longMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(cam_longitude) FROM uas_images where flight_id LIKE '$flightID'")
longMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(cam_longitude) FROM uas_images where flight_id LIKE '$flightID'")
echo $latMIN
echo $latMAX
echo $longMIN
echo $longMAX
query1="INSERT INTO uas_run (record_id,flight_id,start_date,start_time,end_date,end_time,flight_filename,md5sum,lat_min,lat_max,long_min,long_max) VALUES(0,'$runID','$startDate','$startTime','$endDate','$endTime','$flightFileName','$tarFileMD5','$latMIN','$latMAX','$longMIN','$longMAX');"
echo $query1
# Find the boundaries of the CAM utm position
#
CAM_XMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(cam_position_x) FROM uas_images where flight_id LIKE '$flightID'")
CAM_XMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(cam_position_x) FROM uas_images where flight_id LIKE '$flightID'")
CAM_YMIN=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MIN(cam_position_y) FROM uas_images where flight_id LIKE '$flightID'")
CAM_YMAX=$(mysql wheatgenetics -h apate -u mlucas  -se "SELECT MAX(cam_position_y) FROM uas_images where flight_id LIKE '$flightID'")
echo $CAM_XMIN
echo $CAM_XMAX
echo $CAM_YMIN
echo $CAM_YMAX


# Formulate the query statement
#
query2="INSERT INTO uas_run_new (record_id,flight_id,start_date,start_time,end_date,end_time,flight_filename,md5sum,sensor_id,planned_elevation_m,cam_x_min,cam_x_max,cam_y_min,cam_y_max) VALUES(0,'$runID','$startDate','$startTime','$endDate','$endTime','$flightFileName','$tarFileMD5','$cameraID','$elevation','$CAM_XMIN','$CAM_XMAX','$CAM_YMIN','$CAM_YMAX');"
echo $query2
#
#
exit

