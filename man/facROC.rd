\name{facROC}
\alias{facROC}
\title{The function fits a nonparametric analysis of variance model in order to analyse the area under the ROC-curve.}
\usage{
  facROC(formula, id=id, gold=gold, data, logit=FALSE, alpha=0.05)
}
\arguments{
  \item{formula}{a formula specifying the model. The left hand side contains the response variable, and the right hand side the factor variables.}
  \item{id}{a vector which identifies the subjects. The length of id should be the same as the number of observations.}
  \item{gold}{a vector which identifies the goldstandard of each observation coded with 0 and 1. The length of gold should be the same as the number of observations.}
  \item{data}{a data frame in which the variables specified in formula, id and gold will be found.}
  \item{logit}{logical flag: Should a logistic model be applied?}
  \item{alpha}{a numeric specifying the significance level of the confidence intervals; the default option is 0.05}
}
\value{
  Returns an facROC class object with the following components.
  \item{estimators}{the estimators of the AUC for each combination of factor levels as well as the pointwise (1-alpha) confidence intervals.}
  \item{teststatics}{the test statistic, the numerator degrees of freedom (df) of the central F distribution, and the corresponding p-value of the ANOVA-type test; the denominator degrees of freedom is set to infinity.}
  \item{parameters}{containing the parameters of the origninal model}
}
\details{
The function fits nonparamtric analysis of variance model in order to analyse the area under the ROC-Curve. Only factors but
covariates are allowed. Also see print, plot, and summary for summarized outputs.
}
\note{facROC is designed for models with whole-plot and sub-plot factor variables but cannot be applied if several subunits per subject (i.e. clustered data) are observed.}
\examples{
data(diagnostic)
##Performs a logistic analysis evaluating the influence of the factors rater and method###
facAUC <- facROC(score ~  rater*method, id=ID, gold=disease, data=diagnostic, logit=TRUE)
facAUC
##return only the results of the ANOVA-Type-Test
summary(facAUC)
##plot the ROC curves
plot(facAUC)
}
\author{
  Katharina Lange
}