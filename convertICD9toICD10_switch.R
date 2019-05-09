### this function returns possible icd10
convertICD9toICD10 <- function(icd) {
  icd.version <- guess_version(icd)
  icd.format <- icd:::guess_short(icd)
  icd.new <- paste0(icd.version,icd.format,sep = "")
  switch(icd.new,
         "icd9TRUE" = return(findICD10(icd)),
         "icd9FALSE" = return (findICD10(decimal_to_short(icd))),
         "icd10TRUE" = return(icd),
         "icd10FALSE" = return (decimal_to_short(icd))
         )
} 
