summary.facBinary <-
function(x,...){
   cat("Sensitivity \n")
   cat("ANOVA-Type Statistic \n")
   print(x$sensitivity$teststatistic)
   cat("\n")
   cat("Specificity \n")
   cat("ANOVA-Type Statistic \n")
   print(x$specificity$teststatistic)
   cat("\n")
   }
