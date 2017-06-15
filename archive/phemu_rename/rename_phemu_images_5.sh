#!/bin/bash
find /homes/jpoland/images/phemu/phemu_20150518_192317_20150518_202654/ -maxdepth 1  -name "*COM*.txt" | xargs -I{} java -classpath /homes/mlucas/phemucc/ preProcess.ImgRename {} /homes/jpoland/images/phemu/phemu_20150518_192317_20150518_202654/
exit

