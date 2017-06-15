
library(rmarkdown)
args <- commandArgs(trailingOnly = TRUE)
cur=getwd()
##Argument 1 is NDVI file
dataPathNDVI = args[1]
##argument 2 is IRT file
dataPathIRT= args[2]
render("/homes/mlucas/scripts/PhenocornVisualInspection.Rmd", output_file=paste(paste(cur, args[3], sep="/"), ".pdf", sep=""))
