#!/bin/bash
#
# $1 is the path to the GBS files to process
#
#cd /bulk/mlucas/incoming/$1/
gbsFolders=$(find /Users/mlucas/Desktop/$1/raw_data -name "GBS*" -maxdepth 1)
echo $gbsFolders

for file in $gbsFolders; do
   echo $file
   cd $file
   pwd
   #echo "Verifying checksums"
   #date
   #md5CheckResult=$(md5sum -c MD5.txt)
   #echo $md5CheckResult
   #if [[ $md5CheckResult == *"FAIL"* ]]; then   echo "MD5 Check Failed"; fi
   echo "Renaming GBS file and updating flowcell and lane in gbs table"
   python /Users/mlucas/PycharmProjects/GBS/GBS_Utilities/rename_gbs_file.py -p $file -s novogene
   pwd
   echo "Calculating MD5 and line counts for  GBS file"
   find $file -name "*fastq.txt.gz"| xargs -I {} python /Users/mlucas/PycharmProjects/GBS/GBS_Utilities/compute_gbs_file_table_metadata.py -p {}
   echo "Generating QC reports for  GBS File"
   #gbsFile=$(find . -type f -name "*R1*fastq.txt.gz" | sed 's|^./||')
   #echo $gbsFile
   #echo "&&&&&&&&&&&&&&&&"
   #python /Users/mlucas/PycharmProjects/GBS/GBS_Utilities/generate_barcode_distribution-V04.py -i $gbsFile
   find $file -name "*R1*fastq.txt.gz"| xargs -I {} python /Users/mlucas/PycharmProjects/GBS/GBS_Utilities/generate_barcode_distribution-V04.py -i {} -n 1000 -s 1000
   echo "Generating DNA Quantification report"
   gbsFile="$(basename "$file")"
   gbsNumber=$(echo "${gbsFile}" | cut -c1-7)
   echo $gbsNumber
   python /Users/mlucas/PycharmProjects/GBS/GBS_Utilities/dna_quantification_report.py -g $gbsNumber
   echo  "******************************************************************"
done
exit
