# Flag decision tree 


DecisionTree <- function(ICD9code){
  ## Can change ICD9code to the output of findICD10 -> Rename to X 
  x <- findICD10(ICD9code)  # Remove if integrating to a bigger function
  ## Create a base out... Probably remove for iterating. 
  out <- setNames(data.frame(matrix(ncol = 2, nrow = 0)), 
                  c("Details", "ICD10"))
  ### Decision tree 
  if (!unique(x[,2])) {         # If exact match
    out <- rbind(out, data.frame(Details = "Exact_match", ICD10 = x[,1]))
  } else if (unique(x[,3])) {   # If no match
    out <- rbind(out, data.frame(Details = "No_match", ICD10 = NA))
  } else if (unique(!x[,4])) {  # If only one approximate
    out <- rbind(out, 
                 data.frame(Details = rep("Approximate_match", 
                                          length(x[,1])),
                            ICD10 = x$ICD10))
  } else {                      # Then is a combination of codes
    out <- rbind(out, data.frame(Details = rep("Combination", length(x[,1])),
                          ICD10 = x[,1]))
    out <- cbind2(out, x[,5:6])
  }
  return(out)
}
