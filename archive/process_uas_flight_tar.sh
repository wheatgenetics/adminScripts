#!/bin/bash
#
# Change to the staging data directory
#
cd /bulk/jpoland/images/staging
pwd
#
# Find all checksum files and verify that the checksums for the referenced tar.gz files
# are correct. Exit the script if any of the tar.gz files have incorrect checksums.
#
filemd5string=`find -maxdepth 1 -name "uas*.tar.gz" | xargs md5sum`
filemd5=`echo $filemd5string | cut -c1-32`
echo $filemd5
expectedmd5=`cat uas*_md5.txt | cut -d ' ' -f1`
echo $expectedmd5
if [ "$filemd5" != "$expectedmd5" ]
then 
  echo "File checksum does not match expected value...Exiting" && exit
else
  echo "Checksum verified..."
fi
#
# Find any tar files first (*.tar.gz) and gunzip them first.
# Then untar the files to the flight directory containing the data 
# 
find . -maxdepth 1 -name "uas_*.tar.gz" | xargs tar -zxvf
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
cd $flightPath
*imageFolder=`find -maxdepth 1 -wholename "./*" -type d`
*mv $imageFolder/* .
imagePath=$flightPath'/'
echo "Path to Image Files: "$imagePath
imageCount=`ls -1 *.CR2 | wc -l`
#
# Rename any files that have a white space in the name (*.log and *.tlog)
#
rename ' ' '_' *
cd ..
#
# Determine the path to the autopilot log file
#
apLogPath=`find $flightPath -name "*.log"`
echo "Path to Autopilot Log: "$apLogPath
camCount=`grep "CAM, " $apLogPath | wc -l`
camEventCount="$((camCount-1))"
echo "CAM event count= "$camEventCount
echo "Number of Image Files:"
echo $imageCount
#cd ..
#
# Formulate uav metadata file name
#
uasMetadata=$flightPath/uas_metadata_$flightID.csv
echo "UAS Metadata File Name: "$uasMetadata
#
# Wait to let user review the image and CAM event counts
#
echo "Press Enter to Continue"
read
#
# Rescan for the autopilot log name in case it has been edited
#
apLogPath=`find $flightPath -name "*.log"`
echo "Path to Autopilot Log: "$apLogPath
echo "Press Enter to Continue"
read
#
# Rename the image files:rename_image_files.py
#
source /usr/bin/virtualenvwrapper.sh
workon python_2_7_9
~/python2_programs/htp/rename_image_files_v03 -c $cameraID -a $apLogPath -d $imagePath
deactivate
#
# Generate the image metadata 
#
source /usr/bin/virtualenvwrapper.sh
workon python_2_7_9
~/python2_programs/htp/create_uav_metadata_file_v05 -d $imagePath -c $cameraID -a $apLogPath -t CR2 -o $uasMetadata
deactivate
#
exit
