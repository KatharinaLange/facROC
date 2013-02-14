logitCov <- function(AUC,Cov){
if (length(AUC) >1){
   logitCov <- diag(dflogit(AUC)) %*% Cov %*% diag(dflogit(AUC))
  }
else{
  logitCov = dflogit(AUC)^2*Cov
  }
return(logitCov)
}