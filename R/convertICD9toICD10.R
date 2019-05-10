require(icd)

### this function returns possible icd10
convert <- function(icd) {
  icd.version <- guess_version(icd)
  switch(icd.version,
         "icd9" = return(findICD10(icd)),
         "icd10" = return(c(icd))
  )
} # convert function

# Load data
source("loadData.R")
source("findICD10detailed.R")
source("flagDecisionTree.R")

convertICD9toICD10 <- function(icd.table, flag=FALSE) {             # function
  output <- setNames(data.frame(matrix(ncol=2,nrow=0)),
                     c('ICD_input','ICD10'))
  if (flag == FALSE){             # the output without flags
    for (i in icd.table){
      icd.converted = convert(i)
      output <- rbind(output, data.frame(ICD_input=i,ICD10=icd.converted[1]))
    } # for loop
    rownames(output) <- 1:nrow(output)
    return(output)
  } # if statement
  
  else {
    flags <- setNames(data.frame(matrix(ncol=4,nrow=0)),
                   c('ICD10','Details','Scenario','Choice_list'))
    for (i in icd.table){
      icd.converted = convert(i)
      #print(icd.converted)
      output <- rbind(output, data.frame(ICD_input=i,ICD10=icd.converted[1]))
      flag.version <- guess_version(i)
      if (flag.version == "icd10") {
        flags <- rbind(flags, data.frame(ICD10 = i, Details = "Already ICD10",
                                         Scenario = NA, Choice_list = NA))
      } else {
        flag <- DecisionTree(i, short = F)
        flags <- rbind(flags, flag)
      }
    } # for loop
    outputFinal <- merge(output, flags, by='ICD10')
    ifelse(all(is.na(outputFinal$Scenario)),
           return(outputFinal[c(2,1,3)]),
           return(outputFinal[c(2,1,3:5)]))
  } # else
} # convertICD9to ICD10 function 


