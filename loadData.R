install.packages(tidyverse)

## Load the codes
D <- read.table("/cloud/project/2018_I9gem.txt", 
                quote="\"", comment.char="", 
                stringsAsFactors=FALSE)


## Updating the column names so that we know which
## is which
colnames(D) <- c("ICD9", "ICD10", "flag")