#!/bin/bash
#
# Change to staging directory
#
cd /homes/jpoland/images/staging
#
# Find all checksum files and verify that the checksums for the referenced tar.gz files
# are correct. Exit the script if any of the tar.gz files have incorrect checksums.
#
md5sum -c *md5.txt | grep "FAIL" && echo "Incorrect checksum found.Exiting..." && exit
echo "Checksums verified..."
#
# Find any tar files first (*.tar.gz) and gunzip them first.
# Then untar the files to the flight directory containing the data 
# 
#find . -maxdepth 1 -name "*.tar.gz" | xargs gunzip
find . -maxdepth 1 -name "*.tar" | xargs tar -xvf
#
# Find the name of the GNSS file to process
#
gnssFile=`find . -maxdepth 1 -name "GNSS*.txt"`
echo $gnssFile
#
# Convert the GNSS file
#
java -classpath /homes/mlucas/phenocc/ preprocessing.GpsRawProcess $gnssFile
#
# Find the name of the Img file to process
#
imgFile=`find . -maxdepth 1 -name "Img_COM*.txt"`
echo $imgFile
#
# Find the name of the folder containing the images to be processed
#
imgFolder=`find -maxdepth 1 -name "COM*" -type d`/
echo $imgFolder
#
# Convert the image file
#
java -classpath /homes/mlucas/phenocc/ preprocessing.ImgRename $imgFolder $imgFile
#
# Find the name of the processed image and GNSS files used for metadata generation
#
gnssP1File=`find -name "GNSS*p1.txt"`
imgP1File=`find -name "Img*p1.txt"`
#
# Generate the image database metadata file
#
java -classpath /homes/mlucas/phenocc/ preprocessing.ImgLinkProcess $gnssP1File $imgP1File
#
#
#
exit
