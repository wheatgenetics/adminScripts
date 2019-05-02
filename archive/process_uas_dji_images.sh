#!/bin/bash
#
# June 19,2017 This script will allow the user to select a DJI X3 or X5 image data set and
# execute the program required to create a metadata file for import into the uas_images table
# in the wheatgenetics database.
#
# Change to staging directory
#
#
stagingFolder=/bulk/jpoland/images/staging/
uasStagingFolder=/bulk/jpoland/images/staging/uas_staging/
cd $uasStagingFolder
echo "Working Directory: " $uasStagingFolder
#
# Get list of uas data sets and select one to process
#
prompt="Please select a file:"
options=( $(find -maxdepth 1 -print0 | xargs -0) )

PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
#   echo  "You picked $opt which is file $REPLY"
	break

    else
	echo "Invalid option. Try another one."
    fi
done    
#echo $opt
dataSet=`echo $opt | cut -c3-`
echo " "
echo "Selected Data Set is "$dataSet
echo " "
#
# Copy selected data set folder to staging directory
#
mvSource=$uasStagingFolder$dataSet
echo "Source Directory:" $mvSource
echo " "
mvTarget=$stagingFolder$dataSet
echo "Target Directory:"$mvTarget
mv $mvSource $mvTarget
echo " "
cd $mvTarget

#
# Determine the path to the folder containing the image files
# Assume that image folder names are of the form DJI_A01733_C001_20170525
#
# N.B. The output of the ls -dm command is a comma separated list of folders
# to process. However, there is a hidden character '\n' after each folder
# name that needs to be deleted before the python program can accept the
# comma separated list. Hence the | tr -d '\n'` command to remove the
# extraneous '\n'
#
imageFolders=`ls -dm $mvTarget/*/ | tr -d '\n'`
echo "Path to Image Folders: "$imageFolders
echo " "
#
# Determine the full path to the DJIlog file
# Assume that log name is of the form 2017-05-25_12-58-36_v2.csv
#
logPath=`ls $mvTarget/*v2.csv`
echo "Path to DJI Log: "$logPath
echo " "
#
# Determine file type of images.
# For now assume they are always '.dng'
# Future:
# a) update python program to include following 'line file, ext = os.path.splitext(path)'
# b) Use bash
# filename=$(basename "$FullFileNameOfInterest")
# extension="${filename##*.}"
# filename="${filename%.*}"
#
imageType=dng
echo $imageType
echo "Image Type"
echo " "

#
# Put the output files in the data set directory
#
outPath=$mvTarget'/'
echo "Output files will be stored in"$outPath
echo ""
#
# Generate the image metadata
#
# N.B. Have to execute .py file because it has not yet been determined how to include the required
# geos library (needed by shapely) in the compiled program.
#
#   -d DIR,     --dir DIR     Beocat directory path to HTP imagefiles
#   -l LOG,     --log LOG     Flight Log File name
#   -t TYPE,    --type TYPE  Image file type extension, e.g. DNG,CR2, JPG
#   -o OUT,     --out OUT     Output folder path
#   -r RENAME,  --rename RENAME Rename image files Y or N Default = N
#   -x DEBUG,   --debug DEBUG Dump interpolated log file Y or N Default = N
#   -e EXPT,    --expt EXPT  Plot prefix for experiment Default = 17ASH%
#   -n LONZONE, --lonzone LONZONE Longitude Zone Default = 14
#   -z LATZONE, --latzone LATZONE Latitude Zone = Default = S

#
source /usr/bin/virtualenvwrapper.sh
workon python_2_7_9
#
# Set path to geos library required by shapely
#
echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/homes/mlucas/geos/lib
echo $LD_LIBRARY_PATH
echo " "
echo '**********'
echo "Image Folders :"$imageFolders
echo "Input Log Path:"$logPath
echo "Image Type    :"$imageType
echo "Output Path   :"$outPath
echo '**********'
echo " "
#
# Process the data
#
python ~/python2_programs/htp/create_uav_dji_x_metadata_file_v05.py -d $imageFolders -l $logPath -t $imageType -o $outPath
deactivate
#
exit
