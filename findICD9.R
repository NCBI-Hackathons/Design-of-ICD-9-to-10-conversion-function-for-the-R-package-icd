
## function that inputs ICD10code and
## D (conversion data) and outputs
## the ICD9code

findICD9 <- function(ICD10code, D, children){
  
  ICD9code <- 
    D %>% 
    filter(ICD10 == ICD10code) %>%
    select(ICD9, flag)
  
  return(ICD9code)
}