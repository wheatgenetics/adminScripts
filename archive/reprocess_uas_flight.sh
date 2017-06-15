#!/bin/bash
#
# Change to the staging data directory
#
cd /homes/jpoland/images/staging
pwd
#
# Find any tar files first (*.tar.gz) and gunzip them first.
# Then untar the files to the flight directory containing the data 
# 
find . -maxdepth 1 -name "*.tar" | xargs tar -xvf
#
# Find the directory that was created during the untar operation and list contents
#
flightID=`find -maxdepth 1 -name "uas_2*" -type d | cut -d'/' -f 2`
echo "Flight ID: "$flightID
#
# Determine the camera ID from the operator log for use in image file renaming
#
flightPath=`find -maxdepth 1 -name "uas_2*" -type d`
cameraID='CAM_'`grep "Camera serial#: " $flightPath/Drone*.txt | cut -c19-`
echo "Camera ID: "$cameraID
#
# Determine the path to the folder containing the image files
#
imagePath=$flightPath'/'
echo "Path to Image Files: "$imagePath
#
# Determine the path to the autopilot log file
#
apLogPath=`find . -name "*.log"`
echo "Path to Autopilot Log: "$apLogPath
#
# Formulate uav metadata file name
#
uasMetadata=$flightPath/uas_metadata_$flightID.csv
echo "UAS Metadata File Name: "$uasMetadata
#
# Generate the image metadata 
#
source /usr/bin/virtualenvwrapper.sh
workon python_2_7_6
~/python2_programs/htp/create_uav_metadata_file_v04 -d $imagePath -c $cameraID -a $apLogPath -t CR2 -o $uasMetadata
deactivate
#
exit
