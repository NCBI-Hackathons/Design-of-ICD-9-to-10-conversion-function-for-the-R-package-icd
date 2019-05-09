# Flag decision tree 


DecisionTree <- function(ICD9code){
  findICD10(ICD9code)
}
if (!approximate){ #IF approximate is 0
  # Exact output 1 = 1 
  # Export the ICD10 code as is. Only one result: DONE. 
} else { 
  if (noMap){ #IF noMap is 1
    ## Not available converstion 
    ## Convert output to NA
  } else if (!combination){ #IF combination is 0 
    ## Output will be only one, but is NOT EXACT 
    ## Add a second column "Details" that says Approximate??
  } else {
    ## Scenario and Choicelist mess
  }
}