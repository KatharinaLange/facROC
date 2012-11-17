plotROC <-
function(formula, id=id, gold=gold, data=parent.frame(), ylab="sensitivity", xlab="1-specificity", xlim=c(0,1), ylim=c(0,1),
                      type="l", col=seq(1,24),lty=1,pch=1, legend=TRUE, return=FALSE, ... ){
	call <- match.call()
	m <- match.call(expand.dots = FALSE)
	m <- m[match(c("", "formula", "data", "id", "gold"), names(m))]
	if (is.null(m$id))
        m$id <- as.name("id")
	if (!is.null(m$na.action) && m$na.action != "na.omit") {
        warning("Only 'na.omit' is implemented for facroc\ncontinuing with 'na.action=na.omit'")
        m$na.action <- as.name("na.omit")
    	}
	m[[1]] <- as.name("model.frame")
  m <- eval(m, envir = parent.frame())
	
	Terms <- attr(m, "terms")
	#select only the rows that are factors, not the response(s)
	factors <- rownames(attr(terms(m),"factors"))[rowSums(attr(terms(m),"factors"))!=0]
	effects <- colnames(attr(terms(m),"factors"))
	maineffects <- effects[unlist(lapply((strsplit(effects,":",fixed=TRUE)),length))==1]
	orders <- attr(terms(m), "order")
	y <- as.matrix(model.extract(m, "response"))
	x <- model.matrix(Terms, m, contrasts)
	id <- model.extract(m, id)
	is.nested <- rep(TRUE, length(factors))
	
  f.design.list <- design.list(m, is.nested,factors,y)
  splitted.list <- f.design.list[[1]]
  splitted.response.list <- f.design.list[[2]]
  combinations <- f.design.list[[3]]
  list.for.plot <- list()
  for (i in 1:nrow(combinations)){
      list.for.plot[[i]] <- sensspec(splitted.response.list[[i]],splitted.list[[i]]$"(gold)")
  }


  plot(1,1, ylab=ylab, xlab=xlab, xlim=xlim, ylim=ylim, type="n",...)
  name.of.combination <- matrix(,ncol=ncol(combinations), nrow=nrow(combinations))
  connected.combinations <- matrix(,ncol=1, nrow=nrow(combinations))

  for (i in 1:nrow(combinations)){
      points(list.for.plot[[i]][[2]],list.for.plot[[i]][[1]], type=type, col=col[(i%%length(col)+(i%%length(col)==0)*length(col))],
                                                              lty=lty[(i%%length(lty)+(i%%length(lty)==0)*length(lty))],
                                                              pch=pch[(i%%length(pch)+(i%%length(pch)==0)*length(pch))],...)
      for (i2 in 1:ncol(combinations)){
        name.of.combination[i,i2] <- paste(names(combinations[i2]),combinations[i,i2])
      }
  }
  
  connected.combinations <- apply(name.of.combination,1,paste, collapse=", ")

  if(legend==TRUE){
    legend("bottomright", connected.combinations,col=col,lty=lty, bty = "n")
  }

  names(list.for.plot) =  connected.combinations
  if (return==TRUE){
    return(list.for.plot)
  } 
 }
