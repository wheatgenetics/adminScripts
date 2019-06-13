#!/bin/bash
# This script checks in GBS data by calling 4 python scripts
#
# $1 is the GBS folder in /bulk/altschuler/incoming to process. For example, C202SC19050314
#

date
cd /bulk/altschuler/incoming/$1/

gbsFolders=$(find /bulk/altschuler/incoming/$1/raw_data -maxdepth 1 -name "GBS*" )
echo
echo 'Found the following folders to process:'
printf '%s\n' "${gbsFolders[@]}"

#
# Process each GBS folder
#

for folder in $gbsFolders; do
  echo
  echo '********************'
  date
  echo
  echo "Processing GBS folder:"
  echo $folder
  cd $folder
  echo
  echo "Verifying checksums:"
  md5CheckResult=$(md5sum -c MD5.txt)
  printf '%s\n' "${md5CheckResult[@]}"  
  
  if [[ $md5CheckResult == *"FAIL"* ]]; then
    echo "MD5 Check Failed"
  fi

  echo
  echo "Renaming GBS files and updating flowcell and lane in gbs table:"
  /homes/altschuler/python3_programs/GBS/rename_gbs_file -p $folder -s novogene
  echo
  echo "Generating QC reports for GBS File:"
  find . -name "*R1*fastq.txt.gz"| xargs -I {} /homes/altschuler/python3_programs/GBS/generate_barcode_distribution-V04 -i {}
  echo
  echo "Generating DNA Quantification report:"
  gbsFile="$(basename "$folder")"
  gbsNumber=$(echo "${gbsFile}" | cut -c1-7)
  /homes/altschuler/python3_programs/GBS/dna_quantification_report -g $gbsNumber
  echo
  echo "Calculating MD5 and line counts for GBS file:"
  find . -name "*fastq.txt.gz"| xargs -I {} /homes/altschuler/python3_programs/GBS/compute_gbs_file_table_metadata -p {}
  echo
  echo "Moving  GBS files to sequence archive:"
  find . -name "*fastq.txt.gz"| xargs -I {} chgrp ksu-plantpath-jpoland {}
  find . -name "*fastq.txt.gz"| xargs -I {} chmod a-w {}
  find . -name "*R1*fastq.txt.gz"| xargs -I {} mv {} /bulk/jpoland/sequence/.
  find . -name "*R2*fastq.txt.gz"| xargs -I {} mv {} /bulk/altschuler/PE_sequence/R2_files/.
  echo '********************'
  echo
done

echo "Check-in completed"

exit
