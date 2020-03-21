#!/bin/bash
# This script checks in Psomagen data
#
# $1 is the folder in /bulk/jpoland/raw_data/psomagen to process. For example, 2002UNHX-0520
#

date

cd /bulk/jpoland/raw_data/psomagen/$1/

folders=$(find /bulk/jpoland/raw_data/psomagen/$1 -maxdepth 1 -name "GBS*")

echo
echo 'Found the following folders to process:'
printf '%s\n' "${folders[@]}"

#
# Process each GBS folder
#
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

  # Make all files read only
  $(chmod 0444 *)
done

echo
echo "Check-in completed"

exit
