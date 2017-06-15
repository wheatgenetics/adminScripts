#!/bin/bash
#
# Change to the uav incoming data directory
#
cd ~/incoming/uav
#
# Find all checksum files and verify that the checksums for the referenced tar.gz files
# are correct. Exit the script if any of the tar.gz files have incorrect checksums.
#
#md5sum -c *.md5.txt | grep "FAIL" && echo "Incorrect checksum found.Exiting..." && exit
#echo "Checksums verified..."
#
# Find any tar files first (*.tar.gz) and gunzip them first.
# Then untar the files to the flight directory containing the data 
# 
#find . -name "*.tar.gz" | xargs gunzip
#find . -name "*.tar" | xargs tar -xvf
#
# Find the directory that was created during the untar operation and list contents
#
flightID=`find -maxdepth 1 -name "2*" -type d | cut -d'/' -f 2`
#
# Rename the apm log (*.log), telemetry log (*.tlog) and operator log (*.txt) to flight_id.*
# (This may not be desirable or necessary.)
#
#
# Determine the camera ID from the operator log for use in image file renaming
#
flightPath=`find -maxdepth 1 -name "2*" -type d`
cameraID='CAM_'`grep "Camera serial#" $flightPath/Drone*.txt | cut -c19-`
#
# Determine the path to the folder containing the image files
#
imagePath=`find -maxdepth 2 -name "*image**" -type d`'/'
#
# Determine the path to the autopilot log file
#
apLogPath=`find -name "*.log"`
#
# Formulate uav metadata file name
#
uavMetadata=$flightPath/uav_metadata_$flightID.csv
#
# Rename the image files:rename_image_files.py
#
#source /usr/bin/virtualenvwrapper.sh
#workon python_2_7_6
#~/python2_programs/htp/rename_image_files -c $cameraID -d $imagePath
#deactivate
#
# Generate the image metadata 
#
source /usr/bin/virtualenvwrapper.sh
workon python_2_7_6
~/python2_programs/htp/create_uav_metadata_file_v02 -d $imagePath -c $cameraID -a $apLogPath -t CR2 -o $uavMetadata
deactivate
#
# Move all files to the production directory
#
# TBD
#
exit
