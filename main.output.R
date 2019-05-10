### this is the main function
### the input is a vector with icd codes
### it only takes icd in short format


main.output <- function(icd.table) {
  output <- data.frame(ICDcode_input, ICD10, approximate, noMap, combination,
                       scenario, choicelist)
  for (i in icd.table){
    icd.converted = convertICD9toICD10(i)
    output <- rbind(output, icd.converted)
  }
  return(output)
  
}
