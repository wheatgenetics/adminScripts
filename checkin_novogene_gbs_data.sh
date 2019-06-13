#!/bin/bash
# This script checks in GBS data by calling 4 python scripts
#
# $1 is the GBS folder in /bulk/altschuler/incoming to process. For example, C202SC19050314
#

date
cd /bulk/altschuler/incoming/$1/

gbsFolders=$(find /bulk/altschuler/incoming/$1/raw_data -maxdepth 1 -name "GBS*" )
echo $gbsFolders
#
# Process each GBS folder
#

for file in $gbsFolders; do
  echo "Processing GBS folder: "$file
  cd $file
  d=$(pwd)
  echo "Working Directory: "$d
  echo "Verifying checksums"
  date
  md5CheckResult=$(md5sum -c MD5.txt)
  echo $md5CheckResult
  
  if [[ $md5CheckResult == *"FAIL"* ]]; then
    echo "MD5 Check Failed"
  
  fi

  echo "Renaming GBS file and updating flowcell and lane in gbs table"
  echo "Processing GBS folder: "$file
  date
  /homes/altschuler/python3_programs/GBS/rename_gbs_file -p $file -s novogene
  date
  echo "Generating QC reports for GBS File"
  find . -name "*R1*fastq.txt.gz"| xargs -I {} /homes/altschuler/python3_programs/GBS/generate_barcode_distribution-V04 -i {}
  echo "Generating DNA Quantification report"
  gbsFile="$(basename "$file")"
  gbsNumber=$(echo "${gbsFile}" | cut -c1-7)
  echo $gbsNumber
  date
  /homes/altschuler/python3_programs/GBS/dna_quantification_report -g $gbsNumber
  echo "QC Completed"
  echo "Calculating MD5 and line counts for GBS file"
  date
  find . -name "*fastq.txt.gz"| xargs -I {} /homes/altschuler/python3_programs/GBS/compute_gbs_file_table_metadata -p {}
  date
  echo "Moving  GBS files to sequence archive"
  find . -name "*fastq.txt.gz"| xargs -I {} chgrp ksu-plantpath-jpoland {}
  find . -name "*fastq.txt.gz"| xargs -I {} chmod a-w {}
  find . -name "*R1*fastq.txt.gz"| xargs -I {} mv {} /bulk/jpoland/sequence/.
  find . -name "*R2*fastq.txt.gz"| xargs -I {} mv {} /bulk/altschuler/PE_sequence/R2_files/.
  date
done

echo "QC Completed"
echo "Check-in Completed"

exit
