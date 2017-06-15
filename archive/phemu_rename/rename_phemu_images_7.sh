#!/bin/bash
find /homes/jpoland/images/phemu/phemu_20150508_204142_20150508_213924/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150508_204142_20150508_213924/
exit
