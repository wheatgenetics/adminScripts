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
# Post-process java metadata files to create files updated with run_id and position for platform-independent image database tables

find . -name "Cam*p3.csv" -print | xargs -I {} /homes/mlucas/python2_programs/htp/create_updated_phemu_image_metadata_file_2017_from_p3 -d $pythonInputDir -i {} -g $gnssP1File

exit
