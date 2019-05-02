#!/bin/bash
#find /bulk/jpoland/sequence/ -maxdepth 1 -name $1 | xargs -I{} python2  ~/python2_programs/generate_barcode_distribution/generate_barcode_distribution-V03.py -i {}
find /bulk/jpoland/sequence/ -maxdepth 1 -name $1 | xargs -I{} ~/python2_programs/generate_barcode_distribution/generate_barcode_distribution-V03 -i {}
exit
