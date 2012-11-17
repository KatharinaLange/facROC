design.list <-
function(m, is.nested,factors, y) {
  	nested.factors <- m[(names(m) %in% factors[is.nested==1])]
		combinations <- unique(nested.factors)
		rownames(combinations) <- NULL
		ncombinations <- nrow(combinations)

		FactorColumn=matrix(-1,nrow=nrow(nested.factors),ncol=1)
		for(i1 in 1:nrow(nested.factors)) {
			for(i2 in 1:nrow(combinations)) {
				if(all(nested.factors[i1,] == combinations[i2,])) FactorColumn[i1] = i2
			}
		}

		List.of.subjects = list()
		for(i1 in 1:nrow(combinations)) {
			List.of.subjects[[i1]] = m[FactorColumn==i1,]
		}
		
		List.of.responses = list()
		for(i1 in 1:nrow(combinations)) {
			List.of.responses[[i1]] = y[FactorColumn==i1,]
		}
		
		return(list(List.of.subjects, List.of.responses, combinations))
}
