\name{summary.facROC}
\alias{summary.facROC}
\title{The function returns the results of the ANOVA-type statistic performed by facROC.}
\usage{
  summary.facROC(object, ... )
}
\arguments{
  \item{object}{a facROC object to be plotted}
  \item{...}{Parameters that are passed to the function summary.}
}
\value{}
\examples{
data(diagnostic)
##Performs an analysis evaluating the influence of the factors rater and method###
facAUC <- facROC(score ~  rater*method, id=ID, gold=disease, data=diagnostic)
summary(facAUC)
}
\author{
  Katharina Lange
}