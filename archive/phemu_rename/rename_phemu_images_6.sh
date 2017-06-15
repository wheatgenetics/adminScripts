#!/bin/bash
find /homes/jpoland/images/phemu/phemu_20150512_172504_20150512_181101/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150512_172504_20150512_181101/
exit
