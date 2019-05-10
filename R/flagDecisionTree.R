# Flag decision tree 


DecisionTree <- function(ICD9code, short = T){
  ## Can change ICD9code to the output of findICD10 -> Rename to X 
  x <- findICD10(ICD9code)      # Remove if integrating to a bigger function
                                ## Create a FlagsOut if it not exists already, 
                                ## Useful for vectorizing the function
  names(x)[5:6] <- c("Scenario", "Choice_list")
  FlagsOut <- setNames(data.frame(matrix(ncol = 4, nrow = 0)),
                         c("Details", "ICD10", "Scenario", "Choice_list"))
  ### Decision tree 
  if (unique(is.na(x[,1]))) {   # If ICD9 not found
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = "ICD9 Code not found", ICD10 = NA,
                                 Scenario = NA, Choice_list = NA))
  } else if (!unique(x[,2])) {  # If exact match
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = "Exact_match", ICD10 = x[,1],
                                 Scenario = NA, Choice_list = NA))
  } else if (unique(x[,3])) {   # If no match
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = "No_match", ICD10 = NA,
                                 Scenario = NA, Choice_list = NA))
  } else if (unique(!x[,4])) {  # If only one approximate
    l <- length(x[,1])
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = rep("Approximate_match", l), 
                                 ICD10 = x$ICD10,
                                 Scenario = rep(NA, l),
                                 Choice_list = rep(NA, l)))
  } else {                      # Then is a combination of codes
    x <- x[order(x[,5], x[,6]),]
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = rep("Combination", 
                                               length(x[,1])),
                                 ICD10 = x[,1]))
    FlagsOut <- cbind2(FlagsOut, x[,c(5:6)])
  }
  if (short){
    ifelse(all(is.na(FlagsOut$Scenario)), 
           return(FlagsOut[,1:2]),
           return(FlagsOut))
  } else {
    return(FlagsOut)
  }
}
