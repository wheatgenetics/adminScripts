#!/bin/bash
#
# Change to staging directory
#
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
pythonInputDir=$mvTarget'/'
echo "python Input Directory: " $pythonInputDir
#
# Find the GNSS P1 file
#
gnssP1File=`find . -maxdepth 1 -name "*GNSS*p1.csv"`
gnssP1File=`echo $gnssP1File | cut -c3-`
echo "GNSS P1 File:" $gnssP1File
#
# Post-process java metadata files to create files updated with run_id and position for
# platform-independent image database tables
#
#imgLogP401=`find . -maxdepth 1  -name "Cam1LogFile_p4.csv"`
#imgLogP401=`find . -maxdepth 1  -name "6_LogFile_f_p4.csv"`
#imgLogP402=`find . -maxdepth 1  -name "Cam2LogFile_p4.csv"`
#imgLogP403=`find . -maxdepth 1  -name "Cam3LogFile_p4.csv"`
#imgLogP404=`find . -maxdepth 1  -name "1_Cam1LogFile_p4.csv"`
#imgLogP405=`find . -maxdepth 1  -name "1_Cam2LogFile_p4.csv"`
#imgLogP406=`find . -maxdepth 1  -name "1_Cam3LogFile_p4.csv"`
#imgLogP407=`find . -maxdepth 1  -name "2_Cam1LogFile_p4.csv"`
#imgLogP408=`find . -maxdepth 1  -name "2_Cam2LogFile_p4.csv"`
#imgLogP409=`find . -maxdepth 1  -name "2_Cam3LogFile_p4.csv"`
imgLogP410=`find . -maxdepth 1  -name "Cam1LogFile_f_p4.csv"`
imgLogP411=`find . -maxdepth 1  -name "Cam2LogFile_f_p4.csv"`
imgLogP412=`find . -maxdepth 1  -name "Cam3LogFile_f_p4.csv"`

#echo "Cam1 P4 File: " $imgLogP401
#echo "Cam2 P4 File: " $imgLogP402
#echo "Cam3 P4 File: " $imgLogP403
#echo "Cam4 P4 File: " $imgLogP404
#echo "Cam5 P4 File: " $imgLogP405
#echo "Cam6 P4 File: " $imgLogP406
#echo "Cam7 P4 File: " $imgLogP407
#echo "Cam8 P4 File: " $imgLogP408
#echo "Cam9 P4 File: " $imgLogP409
echo "Cam10 P4 File: " $imgLogP410
echo "Cam11 P4 File: " $imgLogP411
echo "Cam12 P4 File: " $imgLogP412

#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP401 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP402 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP403 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP404 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP405 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP406 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP407 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP408 -g $gnssP1File
#/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP409 -g $gnssP1File
/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP410 -g $gnssP1File
/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP411 -g $gnssP1File
/homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017  -d $pythonInputDir -i $imgLogP412 -g $gnssP1File


exit
