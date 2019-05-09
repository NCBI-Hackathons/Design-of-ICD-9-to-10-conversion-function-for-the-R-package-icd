# Flag decision tree 


DecisionTree <- function(ICD9code){
  x <- findICD10(ICD9code)
}
if (!x$approximate){ #IF approximate is 0
  ## Exact output 1 = 1 
  out <- data.frame(ICD10 = x$ICD10, Details = "Exact Match") 
} else { 
  if (x$noMap){ #IF noMap is 1
    ## Not available converstion 
    out <- data.frame(ICD10 = NA, Details = "Not available conversion")
  } else if (!x$combination){ #IF combination is 0 
    ## Output will be only one, but is NOT EXACT 
    out <- data.frame(ICD10 = x$ICD10, Details = "Approximate match")
  } else {
    ## Scenario and Choicelist mess
  }
}