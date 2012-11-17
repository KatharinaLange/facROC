plot.facROC <-
function(x,...){
   global.plotting.parameters.ROC1234 <<- x$parameters
   plotROC(formula=global.plotting.parameters.ROC1234[[1]], id=global.plotting.parameters.ROC1234[[2]], gold=global.plotting.parameters.ROC1234[[3]], data=global.plotting.parameters.ROC1234[[4]],...)
   rm(global.plotting.parameters.ROC1234, envir=.GlobalEnv)
   }
