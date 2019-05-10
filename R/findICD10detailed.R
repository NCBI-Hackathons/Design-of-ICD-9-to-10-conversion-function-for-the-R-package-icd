#Load GEM data
GEM <- readRDS('GEM.RDS') 

## Detailed findICD10 function 

findICD10 <- function(ICD9code) {

  ## Rows that have that ICD9code
  rows <- which(GEM[, 1] == as.character(ICD9code)) 
  ## The ICD10 and flags for those rows
  if (!length(rows)) {
    return(setNames(data.frame(matrix(data = NA, ncol = 6, nrow = 1)),
                    c("ICD10","approximate","noMap","combination",
                      "scenario","choicelist")))
  }
  else {
    return(GEM[rows,c(2, 4:8)])  
  }
}
