comp.ppv <- function(se,sp,pre){
  ppv <- (se*pre)/(se*pre+(1-sp)*(1-pre))
return(ppv)
}

comp.npv <- function(se,sp,pre){
  npv <- (sp*(1-pre))/(sp*(1-pre)+(1-se)*pre)
return(npv)
}

Jacobi.ppv <- function(se,sp,pre){
  if(length(se)>1){
	 Dfse <- as.matrix(diag((pre*(1-pre)*(1-sp))/(pre*se + (1-pre)*(1-sp))^2))
	 Dfsp <- as.matrix(diag((pre*(1-pre)*se / (pre*se+(1-pre)*(1-sp))^2)))
	 Dfpr <- as.matrix(se*(1-sp) / (pre*se+(1-pre)*(1-sp))^2)}
	else{
   Dfse <- as.matrix((pre*(1-pre)*(1-sp))/(pre*se + (1-pre)*(1-sp))^2)
	 Dfsp <- as.matrix((pre*(1-pre)*se / (pre*se+(1-pre)*(1-sp))^2))
	 Dfpr <- as.matrix(se*(1-sp) / (pre*se+(1-pre)*(1-sp))^2)}
	Df <- cbind(Dfse,Dfsp,Dfpr)
return(Df)
}


Jacobi.npv <- function(se,sp,pre){
  if(length(se)>1){
	Dfse <- as.matrix(diag(pre*sp*(1 - pre)/(pre*(se + sp - 1) - sp)^2))
	Dfsp <- as.matrix(diag((pre*(pre - 1)*(se - 1)/(pre*(se + sp - 1) - sp)^2)))
	Dfpr <- as.matrix(sp*(se - 1)/(pre*(se + sp - 1) - sp)^2)}
	else{
	Dfse <- as.matrix(pre*sp*(1 - pre)/(pre*(se + sp - 1) - sp)^2)
	Dfsp <- as.matrix((pre*(pre - 1)*(se - 1)/(pre*(se + sp - 1) - sp)^2))
	Dfpr <- as.matrix(sp*(se - 1)/(pre*(se + sp - 1) - sp)^2)}	
	Df <- cbind(Dfse,Dfsp,Dfpr)
	#Df <- Jacobi.ppv(se=sp,sp=se,pre=1-pre)
return(Df)
}