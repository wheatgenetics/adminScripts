#!/bin/bash
#
# $1 is the path to the GBS files to process
# $2 is the username for the Novogene lftp login
# $3 is the password for the Novogene lftp login 
#
# Download the folder cotaining the GBS data via lftp
echo $1
echo $2
echo $3
date
lftp -e 'mirror $1 /homes/mlucas/'  -u '$2,$3' hwftp.novogene.com
echo $lcmd
date
exit
