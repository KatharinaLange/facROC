data.arragement <-
function(m, is.nested,factors, y){
    crossed.factors <- m[(names(m) %in% factors[is.nested==0])]
    combinations <- unique(crossed.factors)
    rownames(combinations) <- NULL
    ncombinations <- nrow(combinations)

		FactorColumn=matrix(-1,nrow=nrow(crossed.factors),ncol=1)
		for(i1 in 1:nrow(crossed.factors)) {
			for(i2 in 1:nrow(combinations)) {
				if(all(crossed.factors[i1,] == combinations[i2,])) FactorColumn[i1] = i2
			}
		}
    n =   length(unique(m$"(id)"))
 		matrix.of.responses = matrix(,ncol=nrow(combinations), nrow=n)
 		subjects <- unique(m$"(id)")
    rownames(matrix.of.responses) = subjects
    
		for(i1 in 1:nrow(combinations)) {
		  for(i2 in 1:n)
			matrix.of.responses[i2,i1] = y[m$"(id)"==subjects[i2] & FactorColumn==i1]
		}
		
		
		
   return(list(matrix.of.responses,combinations))
}
