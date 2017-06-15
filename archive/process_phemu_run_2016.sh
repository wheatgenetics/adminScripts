#!/bin/bash
#
# Change to staging directory
#
#
# Read in the Height Sensor Boom Height in meters
#
read -p "Enter the boom height for this run in meters: " boomHeight
echo "The boomHeight entered was $boomHeight "
read -p "Hit any key to continue"
echo "Continuing..."

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
pythonInputDir=$mvTarget'/'
echo $pythonInputDir
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
gnssP1File=`echo $gnssP1File | cut -c3-`
echo $gnssP1File
#
# Process the Greenseeker File
#
gseekerFile=`find . -maxdepth 1 -name "*GreenSeekerData.txt"`
gseekerFile=`echo $gseekerFile | cut -c3-`
echo $gseekerFile
java -classpath /homes/mlucas/HTP_Processing/ ndvi_gsk_no_offset.preProcess.GskPreProc $gseekerFile $gnssP1File
#
# Process the Height Sensor File
#
htSensorFile=`find . -maxdepth 1 -name "*HeightSensorData.txt"`
htSensorFile=`echo $htSensorFile | cut -c3-`
echo $htSensorFile
java -classpath /homes/mlucas/HTP_Processing/ height_usc.preProcess.HgtPreProc $htSensorFile $gnssP1File $boomHeight
#
# Create the updated HeightSensor metadata files to load wheatgenetics and phenomics_test database
#
htSensorP3File=`find . -maxdepth 1 -name "*HeightSensorData_p3.txt"`
htSensorP3File=`echo $htSensorP3File | cut -c3-`
echo $htSensorP3File
~/python2_programs/htp/create_updated_phemu_htp_metadata -d $pythonInputDir -i $htSensorP3File -g $gnssP1File
#
# Create the updated GreenSeeker metadata files to load wheatgenetics and phenomics_test database
#
gseekerP3File=`find . -maxdepth 1 -name "*GreenSeekerData_p3.txt"`
gseekerP3File=`echo $gseekerP3File | cut -c3-`
echo $gseekerP3File
~/python2_programs/htp/create_updated_phemu_htp_metadata -d $pythonInputDir -i $gseekerP3File -g $gnssP1File
#exit
#
# Assign variables for processing the images for the first camera
#
imgLog01=`find ./Cam1 -maxdepth 2  -name "LogFile.txt"`
echo $imgLog01
imgFolder01=`echo $imgLog01 | cut -d'/' -f1-3`
imgFolder01=$imgFolder01'/'
echo $imgFolder01
camera01=1
echo $camera01
cam1Time=`echo $imgFolder01 | cut -d'/' -f3`
echo $cam1Time
imgDate01=`echo $gnssP1File | cut -c1-10`
echo $imgDate01
imgLogNew01='./'$imgDate01'_'$cam1Time'_Cam1_LogFile.txt'
echo $imgLogNew01
cp $imgLog01 $imgLogNew01
#
# Process the images for Cam1
#
java -classpath /homes/mlucas/HTP_Processing/ img_preprocess.ImgPreProc $imgLogNew01 $camera01 $gnssP1File $imgFolder01
#
# Assign variables for processing the images for the second camera
#
imgLog02=`find ./Cam2 -maxdepth 2  -name "LogFile.txt"`
echo $imgLog02
imgFolder02=`echo $imgLog02 | cut -d'/' -f1-3`
imgFolder02=$imgFolder02'/'
echo $imgFolder02
camera02=2
echo $camera02
cam2Time=`echo $imgFolder02 | cut -d'/' -f3`
echo $cam2Time
imgDate02=`echo $gnssP1File | cut -c1-10`
echo $imgDate02
imgLogNew02='./'$imgDate02'_'$cam2Time'_Cam2_LogFile.txt'
echo $imgLogNew02
cp $imgLog02 $imgLogNew02
#
# Process the images for Cam2
#
java -classpath /homes/mlucas/HTP_Processing/ img_preprocess.ImgPreProc $imgLogNew02 $camera02 $gnssP1File $imgFolder02
#
# Assign variables for processing the images for the third camera
#
imgLog03=`find ./Cam3 -maxdepth 2  -name "LogFile.txt"`
echo $imgLog03
imgFolder03=`echo $imgLog03 | cut -d'/' -f1-3`
imgFolder03=$imgFolder03'/'
echo $imgFolder03
camera03=3
echo $camera03
cam3Time=`echo $imgFolder03 | cut -d'/' -f3`
echo $cam3Time
imgDate03=`echo $gnssP1File | cut -c1-10`
echo $imgDate03
imgLogNew03='./'$imgDate03'_'$cam3Time'_Cam3_LogFile.txt'
echo $imgLogNew03
cp $imgLog03 $imgLogNew03
#
# Process the images for Cam3
#
java -classpath /homes/mlucas/HTP_Processing/ img_preprocess.ImgPreProc $imgLogNew03 $camera03 $gnssP1File $imgFolder03

#
# Assign variables for processing the images for the fourth camera
#
imgLog04=`find ./Cam4 -maxdepth 2  -name "LogFile.txt"`
echo $imgLog04
imgFolder04=`echo $imgLog04 | cut -d'/' -f1-3`
imgFolder04=$imgFolder04'/'
echo $imgFolder04
camera04=4
echo $camera04
cam4Time=`echo $imgFolder04 | cut -d'/' -f3`
echo $cam4Time
imgDate04=`echo $gnssP1File | cut -c1-10`
echo $imgDate04
imgLogNew04='./'$imgDate04'_'$cam4Time'_Cam4_LogFile.txt'
echo $imgLogNew04
cp $imgLog04 $imgLogNew04
#
# Process the images for Cam4
#
java -classpath /homes/mlucas/HTP_Processing/ img_preprocess.ImgPreProc $imgLogNew04 $camera04 $gnssP1File $imgFolder04

#
# Assign variables for processing the images for the fourth camera
#
gnssP1File=`find . -maxdepth 1 -name "*GNSS*p1.txt"`
gnssP1File=`echo $gnssP1File | cut -c3-`
echo $gnssP1File
camera05=5
echo $camera05
imgDate05=`echo $gnssP1File | cut -c1-10`
echo $imgDate05

for file in $(find ./Cam5 -maxdepth 2  -name "LogFile.txt")
do
imgFolder05=`echo ${file} | cut -d'/' -f1-3`
imgFolder05=$imgFolder05'/'
echo $imgFolder05
cam5Time=`echo $imgFolder05 | cut -d'/' -f3`
echo $cam5Time
imgLogNew05='./'$imgDate05'_'$cam5Time'_Cam5_LogFile.txt'
echo $imgLogNew05
cp ${file} $imgLogNew05
#
# Process the images for Cam5
#
java -classpath /homes/mlucas/HTP_Processing/ img_preprocess.ImgPreProc $imgLogNew05 $camera05 $gnssP1File $imgFolder05
done

#
# Post-process java metadata files to create files updated with run_id and position for
# platform-independent image database tables
#
imgLogP401=`find . -maxdepth 1  -name "*Cam1_LogFile_p4.txt"`
imgLogP402=`find . -maxdepth 1  -name "*Cam2_LogFile_p4.txt"`
imgLogP403=`find . -maxdepth 1  -name "*Cam3_LogFile_p4.txt"`
imgLogP404=`find . -maxdepth 1  -name "*Cam4_LogFile_p4.txt"`

/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file -d $pythonInputDir -i $imgLogP401 -g $gnssP1File
/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file -d $pythonInputDir -i $imgLogP402 -g $gnssP1File
/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file -d $pythonInputDir -i $imgLogP403 -g $gnssP1File
/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file -d $pythonInputDir -i $imgLogP404 -g $gnssP1File

for p4file in $(find . -maxdepth 1  -name "*Cam5_LogFile_p4.txt")
do
    imgLogP405=${p4file}
    /homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file -d $pythonInputDir -i $imgLogP405 -g $gnssP1File
done
exit
