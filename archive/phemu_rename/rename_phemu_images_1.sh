#!/bin/bash
find /homes/jpoland/images/phemu/phemu_20150508_204142_20150508_213924/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150508_204142_20150508_213924/
find /homes/jpoland/images/phemu/phemu_20150508_220616_20150508_224458/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150508_220616_20150508_224458/
find /homes/jpoland/images/phemu/phemu_20150512_151915_20150512_162255/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150512_151915_20150512_162255/
find /homes/jpoland/images/phemu/phemu_20150512_172504_20150512_181101/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150512_172504_20150512_181101/
exit
