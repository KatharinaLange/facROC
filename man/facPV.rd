\name{facPV}
\alias{facPV}
\title{The function fits a nonparametric analysis of variance model in order to analyse positive and negative predictive value.}
\usage{
  facPV(facBinary, se, sp, n1, n0, prev, logit=FALSE, test=FALSE, alpha=0.05)
}
\arguments{
  \item{facBinary}{sensitivity, specificity, sample sizes and covariance matrixes are passed over by an object of the class facROC.
   If specified, se, sp, n0 and n1 must not be specified.}
   \item{se}{a vector: sensitivity estimates}
   \item{sp}{a vector: specificity estimates}
   \item{n1}{an interger: number of diseased patients used to estimate se}
   \item{n0}{an interger: number of non-diseased patients used to estimate sp}
   \item{prev}{a 2-dimensional vector: specifing the prevalence in the study by c("#diseased","#total")}
   \item{logit}{logical flag: Should a logistic model be applied?}
   \item{test}{logical flag: Should a test be performed? Requires a facBinary object}
  \item{alpha}{a numeric specifying the significance level of the confidence intervals; the default option is 0.05}
}
\value{
  Returns an facPV class object or an facPVtest with the following components.
  \item{estimators}{the estimators of positive and negative predictive value for each combination of factor levels as well as the pointwise (1-alpha) confidence intervals.}
  \item{teststatics}{only for facPVtest objects: the test statistic, the numerator degrees of freedom (df) of the central F distribution, and the corresponding p-value of the ANOVA-type test; the denominator degrees of freedom is set to infinity.}
}
\details{
The function fits a nonparametric analysis of variance model in order to analyse positive and negative predictive value.
Also see print and summary for summarized outputs.
}
\note{facPV can either be used with a facBinary object or by specifing se, sp, cov.se, cov.sp, n1, n0.
The prevalence pre has to be defined as 2-dimensinal vector indicating the number of diseased patients and the total number of patients in the prevalence study.}
\examples{

data(diagnostic)
fb <- facBinary(score ~ rater*method, id=ID, gold=disease, data=diagnostic, cutoff=2.5, logit=TRUE)
##Calculating predictive values from fb, assuming that 100 of 500 patients of the prevalence study were diseased.
##A logistic model is applied and hypotheses are tested.
facPV(fb, prev= c(100,500), logit=TRUE, test=TRUE)

##Sensitivity and Specificity
se = 72/100
sp = 90/100
##Sample Sizes
n0=100
n1=100
##Calculating predictive values from the study above, assuming that 100 of 500 patients of the prevalence study were diseased.
##A logistic model is applied.
facPV(se=se, sp=sp, n1=n1, n0=n0, prev= c(100,500), logit=TRUE)
}
\author{
  Katharina Lange
}