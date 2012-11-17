\name{print.facROC}
\alias{print.facROC}
\title{The function prints the corresponding facROC object.}
\usage{
  print.facROC(x, ... )
}
\arguments{
  \item{x}{a facROC object to be printed}
  \item{...}{Parameters that are passed to the function print.}
}
\value{
 Returns the results of the analysis performed by facROC.}
\examples{
data(diagnostic)
##Performs an analysis evaluating the influence of the factors rater and method###
facAUC <- facROC(score ~  rater*method, id=ID, gold=disease, data=diagnostic)
print(facAUC)
}
\author{
  Katharina Lange
}