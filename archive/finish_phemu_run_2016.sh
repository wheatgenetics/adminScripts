#!/bin/bash
#
echo Enter run_id:
read runID
echo $runID
# Declare Variables
#
phemuProdFolder=/bulk/jpoland/images/phemu/
echo "phemu production folder is "$phemuProdFolder
#
# Change to the phemu incoming data directory
#
stagingFolder=/bulk/jpoland/images/staging/
echo "Staging Folder is "$stagingFolder
cd $stagingFolder
echo "Working Directory:"
pwd
runFolder=`find -maxdepth 1 -name "phemu_2*" -type d`
echo "Phemu Run Folder is "$runFolder
cd $runFolder
echo "Working Directory:"
pwd
#
# Delete temporary files created during pre-processingi
# Retain sensor p3 files and image p4 files as requested by Kevin

find . -maxdepth 1 -name "*p1.txt"| xargs rm
find . -maxdepth 1 -name "*p2.txt"| xargs rm
find . -maxdepth 1 -name "*Cam*p3.txt"| xargs rm
find . -maxdepth 1 -name "*.csv"| xargs rm
find . -maxdepth 1 -name "*p4r.txt" | xargs rm
find . -maxdepth 1 -name "*p3r.txt" | xargs rm
find . -maxdepth 1 -name "*.sql" | xargs rm
#
# Copy images from Cam* directories to Working directory
#
find ./Cam1 -maxdepth 2  -name "*_IMG_*.JPG" | xargs mv -t .
find ./Cam2 -maxdepth 2  -name "*_IMG_*.JPG" | xargs mv -t .
find ./Cam3 -maxdepth 2  -name "*_IMG_*.JPG" | xargs mv -t .
find ./Cam4 -maxdepth 2  -name "*_IMG_*.JPG" | xargs mv -t .
find ./Cam5 -maxdepth 2  -name "*_IMG_*.JPG" | xargs mv -t .
#
# tar the raw source files
#
tarSourceFolder=$runID'_source_files.tar'
echo $tarSourceFolder
tar -zcvf $tarSourceFolder *.txt
#
# tar the unmatched images in Cam*
#
tarUnmatchedFolder=$runID'_unmatched_images.tar'
echo $tarUnmatchedFolder
tar -zcvf $tarUnmatchedFolder Cam*
#
# Change permissions and group on the run directory and rename with run_id
#
cd ..
runFileName=$runID
echo $runFileName
mv $runFolder $runFileName
phemuProd_Folder=$phemuProdFolder | cut -c3-
echo $phemuProdFolder
mv $runFileName $phemuProdFolder.
cd $phemuProdFolder
chgrp -R ksu-plantpath-jpoland $runFileName
#chmod -R u-w $runFileName
exit
