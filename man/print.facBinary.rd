\name{print.facBinary}
\alias{print.facBinary}
\title{The function prints the corresponding facBinary object.}
\usage{
  print.facBinary(x, ... )
}
\arguments{
  \item{x}{a facBinary object to be printed}
  \item{...}{Parameters that are passed to the function print.}
}
\value{
 Returns the results of the analysis performed by facBinary.}
\examples{
data(diagnostic)
##Performs an analysis evaluating the influence of the factors rater and method###
facB <- facBinary(score ~  rater*method, id=ID, gold=disease, data=diagnostic, cutoff=2.5)
print(facB)
}
\author{
  Katharina Lange
}