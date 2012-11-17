ANOVA.type <-
function(n, AUC,C, Vn){
  T <- t(C) %*% MASS::ginv(C%*%t(C)) %*% C
  TV <- T %*% Vn
  anova <- n*tr(TV)/tr(TV%*%TV) * t(AUC) %*% T %*% AUC
  df <- tr(TV)*tr(TV) / tr(TV%*%TV)
  p <-1- pchisq(anova,df)
  return(c(round(anova,4),df,round(p,4)))
}
