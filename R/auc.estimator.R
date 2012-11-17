auc.estimator <-
function(v,m) {
     deseased <- v[rownames(v) %in% unique(m$"(id)"[m$"(gold)"==1]), ]
     n1 <- nrow(deseased)
     non.deseased <-v[rownames(v) %in% unique(m$"(id)"[m$"(gold)"==0]), ]
     n0 <-nrow(non.deseased)
     oranks <- apply(v,2,rank)
     AUC <- 1/n0 * ( apply(oranks[rownames(oranks) %in% unique(m$"(id)"[m$"(gold)"==1]), ],2,mean) - (n1+1)/2)
     return(list(AUC,n0+n1))
}
