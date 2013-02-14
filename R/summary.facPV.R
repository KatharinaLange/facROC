summary.facPV <-
function(object,...){
   cat("Positve Predictive Value(s) \n")
   print(object$ppv)
   cat("\n")
   cat("Negative Predictive Value(s)\n")
   print(object$npv)
   cat("\n")
   }
