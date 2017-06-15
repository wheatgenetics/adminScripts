#!/bin/bash
#
# Change to the staging directory
#
cd /homes/jpoland/images/staging
#
# Find all checksum files and verify that the checksums for the referenced tar.gz files
# are correct. Exit the script if any of the tar.gz files have incorrect checksums.
#
filemd5string=`find -maxdepth 1 -name "*.tar.gz" | xargs md5sum`
filemd5=`echo $filemd5string | cut -c1-32`
echo $filemd5
expectedmd5=`cat *_md5.txt | cut -d ' ' -f4`
echo $expectedmd5
if [ "$filemd5" != "$expectedmd5" ]
then 
  echo "File checksum does not match expected value...Exiting" && exit
else
    echo "Checksum verified..."
fi
#
# Find any tar files and untar them
# 
find . -maxdepth 1 -name "*.tar.gz" | xargs gunzip
find . -maxdepth 1 -name "*.tar" | xargs tar -xvf
#
# Find the name of the run directory containing the Phenocorn file
#
runFolder=`find -maxdepth 1 -name "2*" -type d | cut -d'/' -f 2`
echo "Run Data folder: "$runFolder
cd $runFolder
#
# Find the name of the Phenocorn file to process. Normally, Field1_date_time.txt.
#
rename ' ' '' *
#pcornFile=`find . -name "Field1*.txt"`
pcornFile=`find . -name "*.txt"`
echo "Processing File: "$pcornFile
#
# Convert the GNSS file
#
java -classpath /homes/mlucas/phenocc/ preprocessing.ProcFiles $pcornFile
#
# Find the name of the IRT file to process
#
irtFile=`find -name "*IRT.txt"`
echo $irtFile
#
# Find the name of the NDVI file to process
#
ndviFile=`find -name "*NDVI.txt"`
echo $ndviFile
#
# Find the name of the Video Image files to process
#
videoFile=`find -name "*Video.txt"`
echo $videoFile
#
exit
