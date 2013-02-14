facBinary <-
function(formula, id=id, gold=gold, data= parent.frame(), cutoff=0.5, logit=FALSE, alpha=0.05){
call <- match.call()
m <- match.call(expand.dots = FALSE)
m <- m[match(c("", "formula", "data", "id", "gold"), names(m))]
m[[1]] <- as.name("model.frame")
m <- eval(m, parent.frame())
y <- as.matrix(model.extract(m, "response"))
Terms <- terms(m)
response <- as.character(formula[2])
if (min(m$"(id)")<0){stop("ID Variable is not allowed to be smaller than 0.")}
if (any(y==cutoff)){warning("Some observations cannot be classified as diseased or non-diseased because they are equal to the cut-off.")}
if(!(all(m$"(gold)" %in% c(0,1)))){stop("The goldstandard must be classified as 0 and 1.")}
if(all(y<=cutoff)){warning("You may not have choosen an appropriate cutoff, all subjects are classified as non-diseased.")}
if(all(y>=cutoff)){warning("You may not have choosen an appropriate cutoff, all subjects are classified as diseased.")}


if (any(m$"(gold)"==1)) {
data.sens <- pseudo.sens <- m[m$"(gold)"==1,]
pseudo.sens$"(id)" <- -as.numeric(as.factor(pseudo.sens$"(id)"))
pseudo.sens$"(gold)" <- 0
data.sens <- rbind(data.sens,pseudo.sens)
y.sens <- y[m$"(gold)"==1,]
pseudo.y.sens <-  t(as.matrix(rep(cutoff,length(y.sens))))
y.sens <- c(y.sens,pseudo.y.sens)

data.sens[,(colnames(data.sens)==response)] <- y.sens
data.sens <- data.frame(data.sens)

sens1 <- facROC(formula=formula,id=X.id.,gold=X.gold., data=data.sens,logit=logit,alpha=alpha)
sens= list()
sens$estimators <- sens1$estimators
sens$teststatistic <- sens1$teststatistic
sens$Cov <- sens1$Cov
sens$n <- sens1$n
sens$hypmatrix <- sens1$hypmatrix
}
else{
sens = list()
sens$estimators = "There were no diseased observations found in the dataset."
sens$teststatistic = "."
sens$Cov <- sens1$Cov
sens$n <- sens1$n
sens$hypmatrix <- sens1$hypmatrix}

if (any(m$"(gold)"==0)) {
data.spec <- pseudo.spec <- m[m$"(gold)"==0,]
pseudo.spec$"(id)" <- -as.numeric(as.factor(pseudo.spec$"(id)"))
pseudo.spec$"(gold)" <- 1
data.spec <- rbind(data.spec,pseudo.spec)                         
y.spec <- y[m$"(gold)"==0,]
pseudo.y.spec <-  t(as.matrix(rep(cutoff,length(y.spec))))
y.spec <- c(y.spec,pseudo.y.spec)
#data.sens[,data.sens=response]      <-  y.sens
data.spec[,(colnames(data.spec)==response)] <- y.spec
data.spec <- data.frame(data.spec)

speci1 <- facROC(formula=formula,id=X.id.,gold=X.gold., data=data.spec,logit=logit,alpha=alpha)
speci= list()
speci$estimators <- speci1$estimators
speci$teststatistic <- speci1$teststatistic
speci$Cov <- speci1$Cov
speci$n <- speci1$n
speci$hypmatrix <- speci$hypmatrix
}
else{

speci=list()
speci$estimators  ="There were no non-diseased observations found in the dataset."
speci$teststatistic = "."
speci$Cov <- speci1$Cov
speci$n <- speci1$n
speci$hypmatrix <- speci$hypmatrix}

result <- list(sens,speci)
names(result) <- c("sensitivity", "specificity")
class(result) <- c(class(result), "facBinary")
return(result)
}
