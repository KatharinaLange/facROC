summary.facBinary <-
function(object,...){
   cat("Sensitivity \n")
   cat("ANOVA-Type Statistic \n")
   print(object$sensitivity$teststatistic)
   cat("\n")
   cat("Specificity \n")
   cat("ANOVA-Type Statistic \n")
   print(object$specificity$teststatistic)
   cat("\n")
   }
