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
