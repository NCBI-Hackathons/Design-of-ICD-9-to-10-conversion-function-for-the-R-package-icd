# Flag decision tree 


DecisionTree <- function(ICD9code){
  ## Can change ICD9code to the output of findICD10 -> Rename to X 
  x <- findICD10(ICD9code)      # Remove if integrating to a bigger function
                                ## Create a FlagsOut if it not exists already, 
                                ## Useful for vectorizing the function
  if (!exists("FlagsOut")) {
    FlagsOut <- setNames(data.frame(matrix(ncol = 2, nrow = 0)),
                         c("Details", "ICD10"))
  }
  ### Decision tree 
  if (unique(is.na(x[,1]))) {   # If ICD9 not found
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = "ICD9 Code not found", ICD10 = NA))
  } else if (!unique(x[,2])) {  # If exact match
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = "Exact_match", ICD10 = x[,1]))
  } else if (unique(x[,3])) {   # If no match
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = "No_match", ICD10 = NA))
  } else if (unique(!x[,4])) {  # If only one approximate
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = rep("Approximate_match",
                                               length(x[,1])), 
                                 ICD10 = x$ICD10))
  } else {                      # Then is a combination of codes
    x <- x[order(x[,5], x[,6]),]
    FlagsOut <- rbind(FlagsOut, 
                      data.frame(Details = rep("Combination", 
                                               length(x[,1])),
                                 ICD10 = x[,1]))
    names(x)[5:6] <- c("Scenario", "Choice_list")
    FlagsOut <- cbind2(FlagsOut, x[,c(5:6)])
  }
  return(FlagsOut)
}
