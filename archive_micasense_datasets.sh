#!/bin/sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mlucas/geos-3.6.2/capi
echo $LD_LIBRARY_PATH
source /usr/bin/virtualenvwrapper.sh
workon python_3_4_5
which python
date
python /homes/mlucas/python3_programs/htp/archive_micasense_images.py -h
python /homes/mlucas/python3_programs/htp/archive_micasense_images.py -d /bulk/jpoland/images/staging/uav_staging -t tif -o /bulk/jpoland/images/staging/uav_processed
date
deactivate
exit

