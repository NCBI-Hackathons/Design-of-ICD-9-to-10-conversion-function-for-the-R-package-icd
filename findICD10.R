
## function that inputs ICD9code and
## D (conversion data) and outputs
## the ICD9code also do you want children
## outpu
findICD10 <- function(ICD9code, D, children) {
  
  ## Something here that makes sure that 
  ## it's short.
  ICD9code <- 
    
    ICD10code <- 
    D %>% 
    filter(ICD9 == ICD9code) %>%
    select(ICD10, flag) 
  
  
  return(ICD10code)
}


