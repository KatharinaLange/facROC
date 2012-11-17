print.facROC <-
function(x,...){
   cat("AUC Estimators \n")
   print(x$estimators)
   cat("\n")
   cat("ANOVA-Type Statistic \n")
   print(x$teststatistic)
   cat("\n")
   }
