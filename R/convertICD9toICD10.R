convertICD9toICD10 <- function(icd.table, flag=FALSE) {             # function
  output <- setNames(data.frame(matrix(ncol=2,nrow=0)),
                     c('ICD_input','ICD10'))
  if (flag == FALSE){             # the output without flags
    for (i in icd.table){
      icd.converted = convert(i)
      output <- rbind(output, data.frame(ICD_input=icd.converted[1],ICD10=icd.converted[2]))
    } # for loop
    rownames(output) <- 1:nrow(output)
    return(output)
  } # if statement
  
  else {
    for (i in icd.table){
      icd.converted = convert(i)
      colnames(icd.converted) <- NULL
      output <- rbind(output, data.frame(ICD_input=icd.converted[1],ICD10=icd.converted[2]))
      flag.version <- guess_version(i)
      if (flag.version == "icd9") {
        flags = DecisionTree(i)
        return(flags)
      } # if
      output <- merge(output, flags, sort=FALSE)
    } # for loop
    return(output)
  } # else
} # convertICD9to ICD10 function 

### this function returns possible icd10
convert <- function(icd) {
  icd.version <- guess_version(icd)
  switch(icd.version,
         "icd9" = return(findICD10(icd)),
         "icd10" = return(c(icd, icd, rep("NA", each=5)))
  )
} # convert function
