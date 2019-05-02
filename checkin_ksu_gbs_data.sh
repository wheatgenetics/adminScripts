#/bin/bash
cd /bulk/mlucas/incoming
mkdir $1
echo $1
date
echo "Downloading GBS data from Basespace"
/homes/mlucas/bs-cp -q --write-md5 //./Project/$1/samples/$1 $1
echo "Verifying checksums"
md5sum -c $1/md5sum.txt
echo "Backing up raw data to NAS"
rsync -av $1 mlucas@129.130.89.146:/volume3/gbs_permanent/KSU_Genomics_Facilty_raw_files/.
echo "Creating GBS file"
/homes/mlucas/python3_programs/GBS/rename_gbs_file -p $1 -s KSU
cd /bulk/mlucas/incoming/$1
pwd
gbsFile=$(find * -maxdepth 1 -name "GBS*.gz") 
echo $gbsFile
echo "Filtering out short reads"
/homes/mlucas/scripts/filter_FASTQ_byLength_outgz.pl $gbsFile 75
filteredGbsFile=$(find * -maxdepth 1 -name "GBS*Fx*.gz")
echo $filteredGbsFile
echo "Calculating MD5 and line counts for filtered GBS file"
/homes/mlucas/python3_programs/GBS/compute_gbs_file_metadata -p $filteredGbsFile
echo "Generating QC reports for filtered GBS File"
/homes/mlucas/python3_programs/GBS/generate_barcode_distribution-V04 -i $filteredGbsFile
echo "Generating DNA Quantification report"
gbsFolder=$1
gbsNumber=GBS${gbsFolder:0:4}
/homes/mlucas/python3_programs/GBS/dna_quantification_report -g $gbsNumber
echo "Moving filtered GBS files to sequence archive"
chgrp ksu-plantpath-jpoland $filteredGbsFile
chmod a-w $filteredGbsFile
mv $filteredGbsFile /bulk/jpoland/sequence/.
echo "Completed"
date
exit
