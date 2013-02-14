\name{facROC-package}
\alias{facROC-package}
\docType{package}
\title{
facROC - analyzing factorial diagnostic trials.
}
\description{
The package fits a nonparametric analysis of variance models in order to analyze factorial diagnostic trials. The package can be used to evaluate most assessments of diagnostic
accuracy in factorial set-ups: the area under the ROC-Curve (AUC), sensitivity and specivicity as well as predictive values. According to the underlying factorial structure, hypotheses are
tested and confindence intervals are computed. 
}
\details{
\tabular{ll}{
Package: \tab facROC\cr
Type: \tab Package\cr
Version: \tab 0.16\cr
Date: \tab 2013-02-14\cr
License: \tab GPL-2\cr
}
The package includes the following functions to analyze the different assessments of diagnostic accuracy:

facROC(formula, id=id, gold=gold, data, logit=FALSE, alpha=0.05): Analyzing the area under the ROC-Curve
facBinary(formula, id=id, gold=gold, data, cutoff=0.5, logit=FALSE, alpha=0.05): Analyzing sensitivity and specificity
facPV(facBinary, se, sp, n1, n0, prev, logit=FALSE, test=FALSE, alpha=0.05): Analyzing predictive values

}
\author{
Katharina Lange <katharina.lange@medizin.uni-goettingen.de>
}
\references{
Lange K.; Brunner E. Sensitivity, specificity and ROC-curves in multiple reader diagnostic trials - A unified, nonparametric approach. Statistical Methodology 2012, 9:490-500.
}
\keyword{Sensitivity, Specificity, AUC, Predictive Values, Factorial Diagnostic Trials, facROC, ROC-Curve}

\examples{
data(diagnostic)
##Performs a logistic analysis evaluating the influence of the factors rater and method###
facAUC <- facROC(score ~  rater*method, id=ID, gold=disease, data=diagnostic, logit=TRUE)
facAUC
##Performs a logistic analysis evaluating the influence of the factors rater and method on sensitvity and specificity###
##Hereby all observations beeing smaller 2.5 are classified as non-diseased, those larger than 2.5 as diseased##
SeSp <- facBinary(score ~  rater*method, id=ID, gold=disease, data=diagnostic, cutoff=2.5, logit=TRUE)
SeSp
##Calculating predictive values from SeSp, assuming that 100 of 500 patients of the prevalence study were diseased.
##A logistic model is applied and hypotheses are tested.
facPV(SeSp, prev= c(100,500), logit=TRUE, test=TRUE)
}



