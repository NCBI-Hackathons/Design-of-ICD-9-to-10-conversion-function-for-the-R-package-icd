
## Flags to long form.

longFlags <- function(D){
  
  ## The column labels for when we convert to long form
  col_names <- c("Approximate",
                 "NoMap",
                 "Combo",
                 "Scenario",
                 "Choice")
  
  ## The number of each one
  count <- as.numeric((table(D[, "flag"]))) 
  
  M <- matrix(NA, nrow = nrows(D), ncol = length(col_names))
  
  for(i in 1:length(col_names)){
    M[,i] <- 
  }
  
  
}
