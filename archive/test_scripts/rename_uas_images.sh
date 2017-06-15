#!/bin/bash
#
# Change to the uav incoming data directory
#
cd ~/incoming/uav
#
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
# Rename the image files:rename_image_files.py
#
source /usr/bin/virtualenvwrapper.sh
workon python_2_7_6
~/python2_programs/htp/rename_image_files -c $cameraID -d $imagePath
deactivate
#
# Generate the image metadata 
#
#
# Move all files to the production directory
#
exit
