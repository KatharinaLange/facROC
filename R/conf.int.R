conf.int <-
function(n, AUC, Vn, alpha){
  upper <- AUC + sqrt(1/n * diag(Vn))*qnorm(1-alpha/2)
  lower <- AUC - sqrt(1/n * diag(Vn))*qnorm(1-alpha/2)
  return(cbind(lower, upper))
}
