#######################################################################################
####          convertICD9toICD10 function
######################################################################################
### this function returns possible icd10
convertICD9toICD10 <- function(icd, D) {
  icd.version <- guess_version(icd)
  
  # check whether it's icd9 or icd10
  if (icd.version == "icd9") {              # check if it's "icd9"
    #print("OK!")
    #return(icd)
    
    # check whether it's short or decimal
    icd.format <- icd:::guess_short(icd)
    if (icd.format == TRUE) {               # checks for short
      icd.converted <- findICD10B(icd, D)      # if true, converts icd9 to icd10
      return(icd.converted)                 # return the converted icd9 to icd10
    } # if short or decimal 
    else {                                  # for decimal format
      icd.coverted <- decimal_to_short(icd) # converts decimal to short
      icd.converted <- findICD10B(icd.converted, D)  # converts icd9 to icd10
      return(icd.converted)                 # return the converted icd9 to icd10
    } # else short or decimal
  } # if icd9 or icd10
  else {                                    # "icd10"
    icd.format <- icd:::guess_short(icd)    # checks whether it's short or decimal
    if (icd.format == TRUE) {               # if TRUE, returns icd10 in short format
      return(icd)
    } # if short or decimal
    else {                                  # if FALSE
      icd.short <- decimal_to_short(icd)    # converts decimal to short
      return(icd.short)                     # returns icd10 in short format
    } # else short or decimal
  } # else icd 9 or icd10
  
} # end of function

## Coding in base R.

## function that inputs ICD9code and
## D (conversion data) and outputs
## the ICD9code also do you want children

findICD10B <- function(ICD9code, D, children) {
  
  ## Rows that have that ICD9code
  rows <- which(D[, "ICD9"] == ICD9code)
  
  ## The ICD10 and flags for those rows
  ICD10code <- D[rows,c("ICD10", "flag")]
  
  return(ICD10code)
}
