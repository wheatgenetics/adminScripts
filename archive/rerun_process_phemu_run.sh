#!/bin/bash
#
# Change to staging directory
#
#stagingFolder=/homes/jpoland/images/staging/
#phemuStagingFolder=/homes/jpoland/images/staging/phemu_staging/
#cd $phemuStagingFolder
#echo "Working Directory: " $phemuStagingFolder
#
# Get list of phemu data sets and select one to process
#
#prompt="Please select a file:"
#options=( $(find -maxdepth 1 -print0 | xargs -0) )
#
#PS3="$prompt "
#select opt in "${options[@]}" "Quit" ; do 
#    if (( REPLY == 1 + ${#options[@]} )) ; then
#        exit
#
#    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
#	echo  "You picked $opt which is file $REPLY"
#	break
#
#    else
#	echo "Invalid option. Try another one."
#    fi
#done    
#echo $opt
#dataSet=`echo $opt | cut -c3-`
#echo "Selected Data Set is "$dataSet
##
# Copy selected data set folder to staging directory
#
#mvSource=$phemuStagingFolder$dataSet
#echo $mvSource
#mvTarget=$stagingFolder'phemu_'$dataSet
#echo $mvTarget
#mv $mvSource $mvTarget
##
# Change directory to the data set directory
#
mvTarget=/homes/jpoland/images/staging/$1
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
java -classpath /homes/mlucas/phemucc/ preProcess.GpsRawProcess $gnssFile
gnssP1File=`find . -maxdepth 1 -name "*GNSS*p1.txt"`
echo $gnssP1File
#
# Process the Greenseeker File
#
gseekerFile=`find . -maxdepth 1 -name "*GreenSeekerData.txt"`
echo $gseekerFile
java -classpath /homes/mlucas/phemucc/ preProcess.GskPreProc $gseekerFile $gnssP1File
#
# Process the Crop Circle File
#
cropCircleFile=`find . -maxdepth 1 -name "*CropCircleData.txt"`
echo $cropCircleFile
java -classpath /homes/mlucas/phemucc/ preProcess.CclPreProc $cropCircleFile $gnssP1File
#
# Process the Height Sensor File
#
htSensorFile=`find . -maxdepth 1 -name "*HeightSensorData.txt"`
echo $htSensorFile
java -classpath /homes/mlucas/phemucc/ preProcess.HgtPreProc $htSensorFile $gnssP1File
#
# Process the IRT File
#
irtFile=`find . -maxdepth 1 -name "*IRTData.txt"`
echo $irtFile
java -classpath /homes/mlucas/phemucc/ preProcess.IrtPreProc $irtFile $gnssP1File
#
# Assign variables for procssing the images for the first camera
#
imgFolder01=./COM16/
echo $imgFolder01
camera01=1
echo $camera01
#
#
# Find the name of the file containing the image date & time for the first camera
#
#
imgDate01=`find -maxdepth 1 -name "*COM16*.txt"`
echo $imgDate01
#
#
# Convert the image file for the first camera
#
java -classpath /homes/mlucas/phemucc/ preProcess.ImgPreProc $imgDate01 $camera01 $imgFolder01 $gnssP1File
#
# Assign variables for processing the images for the second camera
#
imgFolder02=./COM17/
echo $imgFolder02
camera02=2
echo $camera02
#
#
# Find the name of the file containing the image date & time for the second camera
#
#
imgDate02=`find -maxdepth 1 -name "*COM17*.txt"`
echo $imgDate02
#
#
# Convert the image file for the second camera
#
java -classpath /homes/mlucas/phemucc/ preProcess.ImgPreProc $imgDate02 $camera02 $imgFolder02 $gnssP1File
#
#
# Assign variables for processing the images for the third camera
#
imgFolder03=./COM18/
echo $imgFolder03
camera03=3
echo $camera03
#
#
# Find the name of the file containing the image date & time for the third camera
#
#
imgDate03=`find -maxdepth 1 -name "*COM18*.txt"`
echo $imgDate03
#
#
# Convert the image file for the third camera
#
java -classpath /homes/mlucas/phemucc/ preProcess.ImgPreProc $imgDate03 $camera03 $imgFolder03 $gnssP1File
#
#
# Assign the variables for processing the images for the fourth camera
#
imgFolder04=./COM4/
echo $imgFolder04
camera04=4
echo $camera04
#
#
# Find the name of the file containing the image date & time for the fourth camera
#
#
imgDate04=`find -maxdepth 1 -name "*COM4*.txt"`
echo $imgDate04
#
#
# Convert the image file for the fourth camera
#
java -classpath /homes/mlucas/phemucc/ preProcess.ImgPreProc $imgDate04 $camera04 $imgFolder04 $gnssP1File
#
# Assign the variables for processing the images for the fifth camera
#
imgFolder05=./COM5/
echo $imgFolder05
camera05=5
echo $camera05
#
#
# Find the name of the file containing the image date & time for the fifth camera
#
#
imgDate05=`find -maxdepth 1 -name "*COM5*.txt"`
echo $imgDate05
#
#
# Convert the image file for the fifth camera
#
java -classpath /homes/mlucas/phemucc/ preProcess.ImgPreProc $imgDate05 $camera05 $imgFolder05 $gnssP1File
#
#
# Assign the variables for processing  the images for the sixth camera
#
imgFolder06=./COM19/
echo $imgFolder06
camera06=6
echo $camera06
#
#
# Find the name of the file containing the image date & time for the sixth camera
#
#
imgDate06=`find -maxdepth 1 -name "*COM19*.txt"`
echo $imgDate06
#
#
# Convert the image file for the sixth camera
#
java -classpath /homes/mlucas/phemucc/ preProcess.ImgPreProc $imgDate06 $camera06 $imgFolder06 $gnssP1File

#
exit
