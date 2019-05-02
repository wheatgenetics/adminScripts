#!/bin/bash
#cd /bulk/jpoland/nextera/NEX0002/C202SC19010895/raw_data
#
# $1 is the path to the folder containing the nextera sequence data
#
cd $1
for d in */; do
 ( echo $d && cd "$d" && md5sum -c MD5.txt )
done
exit
