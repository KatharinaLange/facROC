\name{summary.facBinary}
\alias{summary.facBinary}
\title{The function returns the results of the ANOVA-type statistic performed by facBinary.}
\usage{
  summary.facBinary(x, ... )
}
\arguments{
  \item{x}{a facBinary object to be plotted}
  \item{...}{Parameters that are passed to the function summary.}
}
\value{}
\examples{
data(diagnostic)
##Performs an analysis evaluating the influence of the factors rater and method###
facB <- facBinary(score ~  rater*method, id=ID, gold=disease, data=diagnostic, cutoff=2.5)
summary(facB)
}
\author{
  Katharina Lange
}