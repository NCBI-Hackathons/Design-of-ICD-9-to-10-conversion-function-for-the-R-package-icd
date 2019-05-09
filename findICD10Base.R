## Coding in base R.

## function that inputs ICD9code and
## D (conversion data) and outputs
## the ICD9code also do you want children

findICD10B <- function(ICD9code, children = F) {
  
  ## Rows that have that ICD9code
  rows <- which(GEM[, "ICD9"] == ICD9code)
  
  ## The ICD10 and flags for those rows
  ICD10code <- GEM[rows,c("ICD10", "flag")]
  
  return(ICD10code)
}
