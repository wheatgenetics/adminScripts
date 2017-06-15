#!/bin/bash
find /homes/jpoland/images/phemu/phemu_20150512_151915_20150512_162255/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150512_151915_20150512_162255/
exit
