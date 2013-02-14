summary.facPVtest <-
function(object,...){
   cat("Positve Predictive Values \n")
   cat("Positve Predictive Values: Estimators \n")
   print(object$ppv$estimators)
   cat("\n")
   cat("ANOVA-Type Statistic \n")
   print(object$ppv$teststatistics)
   cat("\n")
   cat("Negative Predictive Values \n")
   cat("Negative Predictive Values: Estimators \n")
   print(object$npv$estimators)
   cat("\n")
   cat("ANOVA-Type Statistic \n")
   print(object$npv$teststatistics)
   cat("\n")
   }
