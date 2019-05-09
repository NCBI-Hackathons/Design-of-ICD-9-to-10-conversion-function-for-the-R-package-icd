#######################################################################################
####          convertICD9toICD10 function
######################################################################################


### this function returns possible icd10
convertICD9toICD10 <- function(icd) {
  icd.version <- guess_version(icd)
  
# check whether it's icd9 or icd10
  if (icd.version == "icd9") {                        # check if it's "icd9"
    #print("OK!")
    #return(icd)
    
    # check whether it's short or decimal
    if (icd:::guess_short(icd)){
      return(findICD10(icd))                          # return the converted icd9 to icd10
    }                                                 # if short or decimal 
    else {                                            # for decimal format
      icd.converted <- decimal_to_short(icd)          # converts decimal to short
      return(findICD10(icd.converted))                # return the converted icd9 to icd10
    }                                                 # else short or decimal
  }                                                   # if icd9 or icd10
  else {                                              # "icd10"  
    if (icd:::guess_short(icd)) {                     # checks whether it's short or decimal
      return(icd)                                     # returns icd10 in short format
    }                                                 # if short or decimal
    else {                                            # if FALSE
      return(decimal_to_short(icd))                   # returns icd10 in short format
    }                                                 # else short or decimal
  }                                                   # else icd 9 or icd10
}                                                     # end of function

