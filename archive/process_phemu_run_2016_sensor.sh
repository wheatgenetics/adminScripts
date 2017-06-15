#!/bin/bash
#
# Change to staging directory
#
stagingFolder=/bulk/jpoland/images/staging/
phemuStagingFolder=/bulk/jpoland/images/staging/phemu_staging/
cd $phemuStagingFolder
echo "Working Directory: " $phemuStagingFolder
#
# Get list of phemu data sets and select one to process
#
prompt="Please select a file:"
options=( $(find -maxdepth 1 -print0 | xargs -0) )

PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
	echo  "You picked $opt which is file $REPLY"
	break

    else
	echo "Invalid option. Try another one."
    fi
done    
echo $opt
dataSet=`echo $opt | cut -c3-`
echo "Selected Data Set is "$dataSet
#
# Copy selected data set folder to staging directory
#
mvSource=$phemuStagingFolder$dataSet
echo $mvSource
mvTarget=$stagingFolder'phemu_'$dataSet
echo $mvTarget
mv $mvSource $mvTarget
#
# Change directory to the data set directory
#
cd $mvTarget
pwd
ls
#exit
# Find the name of the GNSS file to process
#
gnssFile=`find . -maxdepth 1 -name "*GNSS*.txt"`
echo $gnssFile
#
# Convert the GNSS file
#
java -classpath /homes/mlucas/HTP_Processing/ height_usc.preProcess.GpsRawProcess $gnssFile
gnssP1File=`find . -maxdepth 1 -name "*GNSS*p1.txt"`
echo $gnssP1File
#
# Process the Greenseeker File
#
gseekerFile=`find . -maxdepth 1 -name "*GreenSeekerData.txt"`
echo $gseekerFile
java -classpath /homes/mlucas/HTP_Processing/ ndvi_gsk_no_offset.preProcess.GskPreProc $gseekerFile $gnssP1File
#
# Process the Height Sensor File
#
htSensorFile=`find . -maxdepth 1 -name "*HeightSensorData.txt"`
echo $htSensorFile
java -classpath /homes/mlucas/HTP_Processing/ height_usc.preProcess.HgtPreProc $htSensorFile $gnssP1File
 preProcess.ImgPreProc $imgDate06 $camera06 $imgFolder06 $gnssP1File
#
exit
