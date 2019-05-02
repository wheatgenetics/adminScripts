#!/bin/bash
find /bulk/jpoland/sequence/ -maxdepth 1 -name $1 | xargs -I{} ~/python3_programs/GBS/generate_barcode_distribution-V04 -i {}
exit
