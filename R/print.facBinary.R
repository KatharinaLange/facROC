print.facBinary <-
function(x,...){
   cat("Sensitivity \n")
   cat("Sensitvity Estimators \n")
   print(x$sensitivity$estimators)
   cat("\n")
   cat("ANOVA-Type Statistic \n")
   print(x$sensitivity$teststatistic)
   cat("\n")
   cat("Specificity \n")
   cat("Specificity Estimators \n")
   print(x$specificity$estimators)
   cat("\n")
   cat("ANOVA-Type Statistic \n")
   print(x$specificity$teststatistic)
   cat("\n")
   }
