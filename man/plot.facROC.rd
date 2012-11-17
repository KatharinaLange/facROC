\name{plot.facROC}
\alias{plot.facROC}
\title{The function plots ROC-Curves of the corresponding facROC object.}
\usage{
  plot.facROC(x, ... )
}
\arguments{
  \item{x}{a facROC object to be plotted}
  \item{...}{Parameters that are passed to the function plot.}
}
\value{
 Returns a plot of ROC-Curves for each combination of factor levels as well as (an optional) list of sensitivity and 1-specificity for each plot.}
\examples{
data(diagnostic)
##Performs an analysis evaluating the influence of the factors rater and method###
facAUC <- facROC(score ~  rater*method, id=ID, gold=disease, data=diagnostic)
##Plots the ROC-Curves for each combination of factor levels##
plot(facAUC)
}
\author{
  Katharina Lange
}