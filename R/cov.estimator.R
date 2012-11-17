cov.estimator <-
function(v,m){
     deseased <- v[rownames(v) %in% unique(m$"(id)"[m$"(gold)"==1]), ]
     n1 <- nrow(deseased)
     non.deseased <-v[rownames(v) %in% unique(m$"(id)"[m$"(gold)"==0]), ]
     n0 <-nrow(non.deseased)
     oranks <- apply(v,2,rank)
     oranks1 <-  oranks[rownames(oranks) %in% unique(m$"(id)"[m$"(gold)"==1]), ]
     oranks0 <-  oranks[rownames(oranks) %in% unique(m$"(id)"[m$"(gold)"==0]), ]
     iranks1 <- apply(deseased,2,rank)
     iranks0 <- apply(non.deseased,2,rank)
     
     z0 <- oranks0 - iranks0
     z1 <- oranks1 - iranks1
     
     z0c <-  -t(apply(z0,2,mean)-t(z0))
     z1c <-  -t(apply(z1,2,mean)-t(z1))
     
     n = n0+n1;
     vn0 <- n/((n-n0)*(n-n0)*n0*(n0-1))*(t(z0c)%*%z0c)
     vn1 <- n/((n-n1)*(n-n1)*n1*(n1-1))*(t(z1c)%*%z1c)
     
     vn <- vn0+vn1
     return(vn)
}
