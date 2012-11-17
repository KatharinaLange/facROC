hypotheses.matrix <-
function(effect, orders, constr.matrix) {
  inv.factors <- as.vector(unlist(strsplit(effect,":",fixed=TRUE)))
  order = length(inv.factors)
  if (order>min(orders)){
  names.matrix <- strsplit(names(constr.matrix),":",fixed=TRUE)
  compare <- lapply(lapply(names.matrix, '%in%', inv.factors),any)
  constr.matrix2 <- constr.matrix[(compare==TRUE) & (orders<order)]
  orders2 <- orders[(compare==TRUE) & (orders<order)]
  sign.sum <- (-1)^(orders2-order)
  for(i in 1:length(sign.sum)){
      constr.matrix2[[i]] <- sign.sum[i] * constr.matrix2[[i]]
  }
  hyp.matrix <-  constr.matrix[[effect]]+Reduce("+",constr.matrix2)}
  else{hyp.matrix <-  constr.matrix[[effect]]}
  
}
