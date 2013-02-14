facPV <- function(facBinary, se, sp, n1, n0, prev, logit=FALSE, test=FALSE, alpha=0.05){

  if (length(prev)!=2) stop("Please enter prev as a vector c(number of diseased,total number of observations.)")
	prv = prev[1]/prev[2]
	
	if(!missing(facBinary)){
		if(!any("facBinary" %in% class(facBinary))) stop("Expected variable facBinary to be output from function facBinary.") 
		sens <- facBinary$sensitivity$estimators$estimator
		cov.sens <- facBinary$sensitivity$Cov
		n <-  facBinary$sensitivity$n
    hyp.matrix <- facBinary$sensitivity$hypmatrix
		spec <- facBinary$specificity$estimators$estimator
		cov.spec <- facBinary$specificity$Cov
		var.prev <- n/prev[2]*prev[2]/(prev[2]-1)*prv*(1-prv)
		Cov <- blockMatrixDiagonal(cov.sens,cov.spec,as.matrix(var.prev))
		res.ppv <- res.npv <- facBinary$sensitivity$estimators
	}
	else{     
    dim.check = c(length(se),length(sp))
    if(min(dim.check) != max(dim.check)) stop("Dimensions of se and sp do not fit.")
		
		n = n1+n0
		sens= se
		cov.se = as.matrix(n1/(n1-1)*se*(1-se))
		cov.sens =as.matrix(n/n1 * cov.se)
		spec= sp
		cov.sp = as.matrix(n0/(n0-1)*sp*(1-sp))
		cov.spec =as.matrix(n/n0 * cov.sp)
		var.prev <- n/prev[2]*prev[2]/(prev[2]-1)*prv*(1-prv)
		Cov <- blockMatrixDiagonal(cov.sens,cov.spec,as.matrix(var.prev))
		results <- matrix(,ncol=3, nrow=length(se))
		colnames(results) <- c("estimator", "lower", "upper")
		res.ppv <- res.npv <- data.frame(results)
	}
	
	ppv <- comp.ppv(sens,spec,prv)
	npv <- comp.npv(sens,spec,prv)
	#Calculating partial derivats
	Df.ppv <- Jacobi.ppv(sens,spec,prv)
	Df.npv <- Jacobi.npv(sens,spec,prv)
	#Calculating Covarance Matrices
	Cov.ppv <- Df.ppv%*%Cov%*%t(Df.ppv)
	Cov.npv <- Df.npv%*%Cov%*%t(Df.npv)
	
	 if (logit==FALSE){
    conf.int.ppv <- conf.int(AUC=ppv,n=n,Vn=Cov.ppv,alpha=alpha)
    conf.int.npv <- conf.int(AUC=npv,n=n,Vn=Cov.npv,alpha=alpha)
    if(test==TRUE){
      if(missing(facBinary)) stop("In order to  use the test option a facBinary object is required.")
      result.test.temp.ppv <- lapply(hyp.matrix,ANOVA.type,n=n,AUC=ppv,Vn=Cov.ppv)
      result.test.ppv <- matrix(unlist(result.test.temp.ppv),ncol=3,byrow=TRUE)
      result.test.temp.npv <- lapply(hyp.matrix,ANOVA.type,n=n,AUC=npv,Vn=Cov.npv)
      result.test.npv <- matrix(unlist(result.test.temp.npv),ncol=3,byrow=TRUE)
    }
    else{
          result.test.ppv ="."
          result.test.npv = "."}
    }  
	else{
    logitppv <- flogit(ppv)
    logitnpv <- flogit(npv)
    logitCov.ppv <- logitCov(ppv,Cov.ppv)
    logitCov.npv <- logitCov(npv,Cov.npv)
    conf.int.ppv <- invlogit(conf.int(AUC=logitppv,n=n,Vn=logitCov.ppv,alpha=alpha))
    conf.int.npv <- invlogit(conf.int(AUC=logitnpv,n=n,Vn=logitCov.npv,alpha=alpha))
    if(test==TRUE){
      if(missing(facBinary)) stop("In order to  use the test option a facBinary object is required.")
      result.test.temp.ppv <- lapply(hyp.matrix,ANOVA.type,n=n,AUC=logitppv,Vn=logitCov.ppv)
      result.test.ppv <- matrix(unlist(result.test.temp.ppv),ncol=3,byrow=TRUE)
      result.test.temp.npv <- lapply(hyp.matrix,ANOVA.type,n=n,AUC=logitnpv,Vn=logitCov.npv)
      result.test.npv <- matrix(unlist(result.test.temp.npv),ncol=3,byrow=TRUE)
    }
    else{
          result.test.ppv ="."
          result.test.npv = "."
          }
 }
	
	

	
	res.ppv$estimator <- ppv
	res.ppv$lower <- conf.int.ppv[,1]
	res.ppv$upper <- conf.int.ppv[,2]
	
	res.npv$estimator <- npv
	res.npv$lower <- conf.int.npv[,1]
	res.npv$upper <- conf.int.npv[,2]
  
  result <- list(res.ppv, res.npv)
  names(result) <- c("ppv", "npv")
  class(result) <- c(class(result), "facPV")
  
 	if(test==TRUE){
  rownames(result.test.ppv) <- rownames(result.test.npv) <-rownames(facBinary$sensitivity$teststatistic)
  colnames(result.test.ppv) <- colnames(result.test.npv) <-  c("Statistic", "df", "p-value")
  res.all.ppv <- list(res.ppv,result.test.ppv)
  names(res.all.ppv) <- c("estimators", "teststatistics")
  res.all.npv <- list(res.npv,result.test.npv)
  names(res.all.npv) <- c("estimators", "teststatistics")
  result <- list(res.all.ppv, res.all.npv)
  names(result) <- c("ppv", "npv")
  class(result) <- c(class(result), "facPVtest", "facPV")
  }
  
  
  return(result)
}
