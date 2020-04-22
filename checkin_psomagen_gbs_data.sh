#!/bin/bash
# This script checks in Psomagen data
#
# Usage: ./checkin_psomagen_gbs_data.sh <folder_name>
#
# $1 is the folder in /bulk/jpoland/raw_data/psomagen to process. For example, 2002UNHX-0520
#

date

cd /bulk/jpoland/raw_data/psomagen/$1/

folders=$(find /bulk/jpoland/raw_data/psomagen/$1 -maxdepth 1 -name "GBS*")

echo
echo 'Found the following folders to process:'
printf '%s\n' "${folders[@]}"
echo

# Change group ownership to ksu-plantpath-jpoland for all files and folders
echo 'Changing group ownership to ksu-plantpath-jpoland for all files and folders'
$(chgrp -R ksu-plantpath-jpoland .)

# Process each GBS folder
for folder in $folders; do
  cd $folder
  echo
  echo '********************'
  date
  echo
  echo "Processing GBS folder:"
  echo $folder
  echo
  md5name=$(basename $folder).md5
  echo "Verifying checksums in ${md5name}:"
  $(md5sum -c ${md5name} > ${md5name}.checked)

  if [[ $md5CheckResult == *"FAIL"* ]]; then
    echo "MD5 Check Failed"
  fi

  echo
#  echo "Renaming GBS files and updating flowcell and lane in gbs table:"
#  python /homes/altschuler/GBS/rename_gbs_file_and_update_flowcell_and_name_in_database.py -p $folder -s psomagen
#  echo

  # Make all files read only
  echo 'Changing all file permissions to read only (444)'
  $(chmod 0444 *)
done

echo
echo "Check-in completed"

exit
