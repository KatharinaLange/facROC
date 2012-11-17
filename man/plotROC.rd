\name{plotROC}
\alias{plotROC}
\title{The function plots ROC-Curves}
\usage{
  plotROC(formula, id=id, gold=gold, data, legend=TRUE, return=FALSE, ... )
}
\arguments{
  \item{formula}{a formula specifying the model. The left hand side contains the response variable, and the right hand side the factor variables.}
  \item{id}{a vector which identifies the subjects. The length of id should be the same as the number of observations.}
  \item{gold}{a vector which identifies the goldstandard of each observation, coded with 0 and 1. The length of gold should be the same as the number of observations.}
  \item{data}{a data frame in which the variables specified in formula, id and gold will be found.}
  \item{legend}{logiocal flag: Should a legend be plotted as well?}
  \item{return}{logical flag: Should the list of sensitivity and 1-specificity used for the plot be returned?}
  \item{...}{Parameters that are passed to the function plot.}
}
\value{
 Returns a plot of ROC-Curves for each combination of factor levels as well as (an optional) list of sensitivity and 1-specificity for each plot.}
\examples{
data(diagnostic)
##Plots the ROC-Curves for each combination of factor levels##
plotROC(score~rater*method,id=ID,gold=disease,data=diagnostic, col=rainbow(6), main="ROC-Plot")
}
\author{
  Katharina Lange
}