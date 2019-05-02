#!/bin/bash
#
# $1 is the path to the GBS files to process
#
set -v
cd /bulk/mlucas/incoming/$1/
cat *.gz.md5
find . -name "*.gz.md5" | xargs md5sum -c
for filename in ./*.gz
do
  echo "${filename}"
  zcat "${filename}" | head -n 1
done
for filename in ./*.gz
do
  echo "${filename}"
  zcat "${filename}" | wc -l 
done
set +v
exit
