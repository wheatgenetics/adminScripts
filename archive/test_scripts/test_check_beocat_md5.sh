#!/bin/bash
#
cd ~/logs
echo "Job Started:"$(date)
nohup nice -n 19 ~/python2_programs/MD5_check/check_beocat_md5_v09_p2 -d /homes/jpoland/sequence/ -f GBS0750 -l GBS0755
echo "Job Ended:"$(date)
exit
