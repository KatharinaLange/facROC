check.nested <-
function(m, factor){
  ##levels of factor
	levels.check.nested <- as.vector(unlist(unique(m[factor])))
	nolevels <- length(levels.check.nested)
  ##for each level a column in the matrix "check" is generated indicating
  ##wether the corresponding obersavation belongs to this level 
	check <- apply(m[factor],1,FUN=function(z,a){z==a}, a=levels.check.nested)
	##in each column where check==TRUE the Patient.ID is written otherwise compare=0
	compare <-t(check) * (m$"(id)" %x% t(rep(1,nrow(check))))
	##sort (the 0s are on top)
  compare.sort <- apply(compare,2,sort)
  comparision<-outer(1:nolevels,1:nolevels, FUN = Vectorize( function(i,j) (all((compare.sort[,i]==compare.sort[,j])))))
  comparision2<-outer(1:nolevels,1:nolevels, FUN = Vectorize( function(i,j) (any((compare.sort[,i]*compare.sort[,j]!=0)*(compare.sort[,i]==compare.sort[,j])))))
  pot.error <- FALSE
  
  if (any(comparision!=comparision2)){
   warning(paste("Data is unbalanced: the factor",factor,"is neither crossed nor nested under ID."))
   pot.error <- TRUE
  }
  
  diag(comparision) <-FALSE
	##as the 0 are only "Platzhalter" they can be deleted
	return(list(all(!comparision),pot.error))
  #return(list(levels.check.nested, check, compare, start.colum.compare, comparision))
}
