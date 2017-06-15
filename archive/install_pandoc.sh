#!/bin/bash
export PATH="$HOME/pandoc:$PATH"
mkdir $HOME/pandoc
curl -O https://s3.amazonaws.com/rstudio-buildtools/pandoc-1.12.3.zip
unzip -j pandoc-1.12.3.zip pandoc-1.12.3/linux/debian/x86_64/pandoc -d $HOME/pandoc 
chmod +x $HOME/pandoc/pandoc
pandoc --version
exit
