print.facPV <-
function(x,...){
   cat("Positve Predictive Value(s) \n")
   print(x$ppv)
   cat("\n")
   cat("Negative Predictive Value(s)\n")
   print(x$npv)
   cat("\n")
   }
