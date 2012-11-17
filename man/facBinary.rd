\name{facBinary}
\alias{facBinary}
\title{The function fits a nonparametric analysis of variance model in order to analyse sensitvity and specificity.}
\usage{
  facBinary(formula, id=id, gold=gold, data, cutoff=0.5, logit=FALSE, alpha=0.05)
}
\arguments{
  \item{formula}{a formula specifying the model. The left hand side contains the response variable, and the right hand side the factor variables.}
  \item{id}{a vector which identifies the subjects. The length of id should be the same as the number of observations.}
  \item{gold}{a vector which identifies the goldstandard of each observation, coded with 0 and 1. The length of gold should be the same as the number of observations.}
  \item{data}{a data frame in which the variables specified in formula, id and gold will be found.}
  \item{cutoff}{a numeric specifying which observations are classified as diseased (>cutoff) or non-diseased (<cutoff)}
  \item{logit}{logical flag: Should a logistic model be applied?}
  \item{alpha}{a numeric specifying the significance level of the confidence intervals; the default option is 0.05}
}
\value{
  Returns an facBinary class object with the following components.
  \item{estimators}{the estimators of sensitvity and specificity for each combination of factor levels as well as the pointwise (1-alpha) confidence intervals.}
  \item{teststatics}{the test statistic, the numerator degrees of freedom (df) of the central F distribution, and the corresponding p-value of the ANOVA-type test; the denominator degrees of freedom is set to infinity.}
}
\details{
The function fits a nonparametric analysis of variance model in order to analyse sensitvity and specificity.
Hereby a specific cutoff has to be choosen before if the endpoint is non-binary. Also see print and summary for summarized outputs.
}
\note{facBinary is designed for models with whole-plot and sub-plot factor variables but cannot be applied if several subunits per subject (i.e. clustered data) are observed.}
\examples{
data(diagnostic)
##Performs a logistic analysis evaluating the influence of the factors rater and method on sensitvity and specificity###
##Hereby all observations beeing smaller 2.5 are classified as non-diseased, those larger than 2.5 as diseased##
facBinary(score ~  rater*method, id=ID, gold=disease, data=diagnostic, cutoff=2.5, logit=TRUE)
}
\author{
  Katharina Lange
}