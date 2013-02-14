print.facPVtest <-
function(x,...){
   cat("Positve Predictive Values \n")
   cat("Positve Predictive Values: Estimators \n")
   print(x$ppv$estimators)
   cat("\n")
   cat("ANOVA-Type Statistic \n")
   print(x$ppv$teststatistics)
   cat("\n")
   cat("Negative Predictive Values \n")
   cat("Negative Predictive Values: Estimators \n")
   print(x$npv$estimators)
   cat("\n")
   cat("ANOVA-Type Statistic \n")
   print(x$npv$teststatistics)
   cat("\n")
   }
