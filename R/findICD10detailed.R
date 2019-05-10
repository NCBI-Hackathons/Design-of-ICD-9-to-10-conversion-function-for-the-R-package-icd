## Detailed findICD10 function 

findICD10 <- function(ICD9code, children = F) {
  GEM <- readRDS('GEM.RDS') #Load GEM data
  ## Rows that have that ICD9code
  rows <- which(GEM[, 1] == as.character(ICD9code)) 
  ## The ICD10 and flags for those rows
  if (!length(rows)) {
    return(data.frame(ICD10 = NA))
  }
  else {
    return(GEM[rows,c(2, 4:8)])  
  }
}
