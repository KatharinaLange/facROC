constr.hypotheses.matrix <-
function(effect,factors.matrix){
  nlevels <- as.matrix(lapply((apply(factors.matrix,1,unique)),length))
  inv.factors <- as.vector(unlist(strsplit(effect,":",fixed=TRUE)))
  inv.factors.matrix <- factors.matrix[(colnames(factors.matrix) %in% inv.factors)]
  combinations <-  inv.factors.matrix
  ncombinations <- nrow(combinations)
  des.matrix <- matrix(,nrow=ncombinations,ncol=nrow(factors.matrix))

  for (i1 in 1:nrow(factors.matrix)){
    for (i2 in 1:ncombinations){
        des.matrix[i2,i1] <- as.numeric(all(combinations[i2,]==inv.factors.matrix[i1,]))
              }
    }
  hyp.matrix <-(apply(des.matrix,2,'/',(apply(des.matrix,1,sum))) - 1/nrow(factors.matrix) *  matrix(1,nrow=ncombinations,ncol=nrow(factors.matrix)))
  #hyp.matrix <- rep(1,nrow(factors.matrix)/ncombinations) %x% hyp.matrix
  return(hyp.matrix)
}
