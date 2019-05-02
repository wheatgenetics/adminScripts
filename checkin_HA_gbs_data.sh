#!/bin/bash
#
# $1 is the path to the GBS files to process
#
cd /bulk/mlucas/incoming/$1/
pwd
date
echo "Renaming GBS file and updating flowcell and lane in gbs table"
cd ..
pwd
/homes/mlucas/python3_programs/GBS/rename_gbs_file -p $1 -s HA
cd /bulk/mlucas/incoming/$1/
pwd
echo "Calculating MD5 and line counts for GBS files"
find . -name "GBS*.gz"| xargs -I {} /homes/mlucas/python3_programs/GBS/compute_gbs_file_metadata -p {}
echo "Generating QC reports for filtered GBS Files"
find . -name "GBS*.gz"| xargs -I {} /homes/mlucas/python3_programs/GBS/generate_barcode_distribution-V04 -i {} 
echo "Generating DNA Quantification reports for GBS files"
for file in /bulk/mlucas/incoming/$1/GBS*.gz; do
    gbsFile="$(basename "$file")"
    gbsNumber=$(echo "${gbsFile}" | cut -c1-7)
    echo $gbsNumber
    /homes/mlucas/python3_programs/GBS/dna_quantification_report -g $gbsNumber
done
echo "Moving GBS files to sequence archive"
find . -name "GBS*.gz"| xargs -I {} chgrp ksu-plantpath-jpoland {}
find . -name "GBS*.gz"| xargs -I {} chmod a-w {}
#find . -name "GBS*.gz"| xargs -I {} mv {} /bulk/jpoland/sequence/.
date
echo "Completed"
exit
