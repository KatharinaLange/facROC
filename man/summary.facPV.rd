\name{summary.facPV}
\alias{summary.facPV}
\title{The function prints the corresponding facPV object.}
\usage{
  summary.facPV(object, ... )
}
\arguments{
  \item{object}{a facPV object to be printed}
  \item{...}{Parameters that are passed to the function print.}
}
\value{
 Returns the results of the analysis performed by facPV.}
\examples{
data(diagnostic)
fb <- facBinary(score ~ rater*method, id=ID, gold=disease, data=diagnostic, cutoff=2.5, logit=TRUE)
##Calculating predictive values from fb, assuming that 100 of 500 patients of the prevalence study were diseased.
##A logistic model is applied and hypotheses are tested.
pv <- facPV(fb, prev= c(100,500), logit=TRUE, test=FALSE)
summary(pv)
}
\author{
  Katharina Lange
}