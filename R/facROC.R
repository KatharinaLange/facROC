facROC <-
function(formula, id=id, gold=gold, data= parent.frame(), logit=FALSE, alpha=0.05){  
	call <- match.call()
	m <- match.call(expand.dots = FALSE)
	m <- m[match(c("", "formula", "data", "id", "gold"), names(m))]
	if (is.null(m$id))               
        m$id <- as.name("id")
	if (!is.null(m$na.action) && m$na.action != "na.omit") {
        warning("Only 'na.omit' is implemented for facROC\ncontinuing with 'na.action=na.omit'")
        m$na.action <- as.name("na.omit")
    	}
	m[[1]] <- as.name("model.frame")
	m <- eval(m, parent.frame())
	Terms <- attr(m, "terms")
	#select only the rows that are factors, not the response(s)
	factors <- rownames(attr(terms(m),"factors"))[rowSums(attr(terms(m),"factors"))!=0]
	effects <- colnames(attr(terms(m),"factors"))
	maineffects <- effects[unlist(lapply((strsplit(effects,":",fixed=TRUE)),length))==1]
	orders <- attr(terms(m), "order")  
	y <- as.matrix(model.extract(m, "response"))
	x <- model.matrix(Terms, m, contrasts)
	id <- model.extract(m, id)
	
  if(!(all(m$"(gold)" %in% c(0,1)))){stop("The goldstandard must be classified as 0 and 1.")}
	
	##Check under which factors the Patient is nested
	f.is.nested <- sapply(factors,check.nested, m=m)
	pot.error <-  unlist(f.is.nested[2,])
	if (any(pot.error == TRUE)){
      clustersize <- table(m$"(id)")
      med <- round(median(clustersize),digits=0)
      incomplete <- names(clustersize[!(clustersize %in% med)])
      incomplete.output <- paste(incomplete, sep=",")
      #incomplete.output <- paste(incomplete.output, collapse="")
      if(length(incomplete)/nrow(m)>0.1){stop("Due to clusterd data or missing values the model could not be recognized. Please check manuelly.")}
      ##warning(paste("In order to archive balancedness the following subject(s)", incomplete.output, "were removed from analysis."))
      warning(paste("In order to archive balancedness", length(incomplete.output), "subject(s) was (were) removed from analysis."))
      m <- m[!(m$"(id)"%in%incomplete),]
     	y <- as.matrix(model.extract(m, "response"))
      x <- model.matrix(Terms, m, contrasts)
      id <- model.extract(m, id)
      f.is.nested2 <- sapply(factors,check.nested, m=m)
      pot.error2 <-  unlist(f.is.nested2[2,])
      if (any(pot.error2 == TRUE)){stop("Due to clusterd data or missing values the model could not be recognized. Please check manually.")}
      is.nested <- unlist(f.is.nested2[1,])      
  }
  else{is.nested <- unlist(f.is.nested[1,])}
 
  
	#return(is.nested)
  ##Split sample into independent subsets according to those factors under which the patient is nested
	if (sum(is.nested) > 0) {
    f.design.list <- design.list(m, is.nested,factors,y)
    splitted.list <- f.design.list[[1]]
    splitted.response.list <- f.design.list[[2]]
    combination.nested <- f.design.list[[3]]
	} else {
    splitted.list <- list()
    splitted.response.list <- list()
		splitted.list[[1]] = m
    splitted.response.list[[1]] = y		
	}
	
	if(TRUE){ 
	##Transform  the data into a matrix notation according to those factors crossed with patient
	if(prod(is.nested)==0){
    vectors.responses = list()
    combination.crossed = list()
    for (i in 1:length(splitted.list)){
      f.data.arragement <- data.arragement(splitted.list[[i]], is.nested,factors,splitted.response.list[[i]])
      ##For each subgroup vectors.responses is the list of vectors for each patient
      vectors.responses[[i]]    <- f.data.arragement [[1]]
      ##How are the crossed factors arragend in the matrix above?
      combination.crossed[[i]]  <- f.data.arragement[[2]]
    }
  } else{
    vectors.responses <- splitted.response.list
    crossed.factors <- m[(names(m) %in% factors[is.nested==0])]
    combination.crossed <- unique(crossed.factors)
  }        
        
  
  ##Estimate the AUC for each of the independent subgroups and count number of cases in each subgroup
  AUC =list()
  nlist = list()
  for (i in 1:length(splitted.list)){
      f.auc.estimator <- auc.estimator(vectors.responses[[i]], splitted.list[[i]])
      AUC[[i]] <- unlist(f.auc.estimator[[1]])
      nlist[[i]] <- rep(unlist(f.auc.estimator[[2]]), length(AUC[[i]]))
    } 
  
  nlist=unlist(nlist)
  if(min(nlist)<8){warning("Samplesize might be too small for an adequat approximation.")}
  if((min(unlist(AUC))==0)|(max(unlist(AUC))==1)){warning("Approximation procedure failed: Some estimators are equal to 0 or equal to 1.")}
  
  ##Crossed / nested factors  
  crossed.factors <-  factors[is.nested==0]
  nested.factors  <-  factors[is.nested==1]
    
  factors.matrix.nested  <- matrix(,ncol=0,nrow=length(nested.factors))
  factors.matrix.crossed <- matrix(,ncol=0,nrow=length(crossed.factors))
  rownames(factors.matrix.nested) <- nested.factors
  rownames(factors.matrix.crossed) <- crossed.factors
	 

  for (i1 in 1:length(AUC)){
	   ##The different results of each nested factor are put together
     if(sum(is.nested) > 0){ 
          factors.matrix.nested <- cbind(factors.matrix.nested, matrix(rep(as.matrix(combination.nested[i1,]),length(AUC[[i1]])),ncol=length(AUC[[i1]])))}
     else{factors.matrix.nested <- matrix(,ncol=length(unlist(AUC)),nrow=0)}
     ##with the crossed factors as well
     if(prod(is.nested)==0){
            factors.matrix.crossed <- cbind(factors.matrix.crossed, t(as.matrix(combination.crossed[[i1]])))}
     else{factors.matrix.crossed <- matrix(,ncol=length(unlist(AUC)),nrow=0)}
   }
  
   factors.matrix <- data.frame(t(rbind(factors.matrix.nested, factors.matrix.crossed)))
   AUC.temp <- as.matrix(round(unlist(AUC),digits=4))
   colnames(AUC.temp) <- "estimator"
	 result.AUC <- data.frame(t(rbind(factors.matrix.nested, factors.matrix.crossed, t(AUC.temp))))
	 rm(AUC.temp)
  
   COV =list()
    for (i in 1:length(splitted.list)){
      COV[[i]] <- cov.estimator(vectors.responses[[i]], splitted.list[[i]])
   }  
  
  AUC = as.vector(unlist(AUC))
  ##Construct the hypotheses matrixes according the model
  constr.hyp.matrix <- lapply(effects,constr.hypotheses.matrix, factors.matrix=factors.matrix)
  names(constr.hyp.matrix) = effects;
  hyp.matrix <- lapply(effects, hypotheses.matrix, orders=orders, constr.matrix=constr.hyp.matrix)
  names(hyp.matrix) <- effects;
  ## Put the covariance matrixes of the different nested factors togetehr
  Cov <-  blockMatrixDiagonal(COV)
  ##Total Sample Size
  n <- sum(unlist(lapply(vectors.responses,nrow)))
  ##Test the different hypotheses either in a logistic or an additive model
  ## & Compute CI
  if (logit==FALSE){
    result.temp <- lapply(hyp.matrix,ANOVA.type,n=n,AUC=AUC,Vn=Cov)
    result <- matrix(unlist(result.temp),ncol=3,byrow=TRUE)
    conf.int <- conf.int(AUC=AUC,n=nlist,Vn=Cov,alpha=alpha)
    }  
  else{
    logitAUC <- flogit(AUC)
    logitCov <- logitCov(AUC,Cov)
    result.temp <- lapply(hyp.matrix,ANOVA.type,n=n,AUC=logitAUC,Vn=logitCov)
    result <- matrix(unlist(result.temp),ncol=3,byrow=TRUE)
    conf.int <- invlogit(conf.int(AUC=logitAUC,n=nlist,Vn=logitCov,alpha=alpha))
  }
  result.AUC <-cbind(result.AUC,conf.int)
  rownames(result) <- effects
  colnames(result) <- c("Statistic", "df", "p-value")
  result <- data.frame(round(result,digits=4))
  parameters <- list(formula, m$"(id)", m$"(gold)", data)
  final <- list(result.AUC,result,parameters,Cov,n, hyp.matrix)
  names(final) <- c("estimators", "teststatistic", "parameters", "Cov", "n", "hypmatrix")
  class(final) <- c(class(final), "facROC")
  #class(final) <- "facROC"
  return(final)
   }
                              
}
