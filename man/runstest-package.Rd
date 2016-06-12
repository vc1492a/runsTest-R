\name{runstest-package}
\alias{runstest-package}
\alias{runstest}
\docType{package}
\title{
\packageTitle{runstest}
}
\description{
\packageDescription{runstest}
}
\author{
\packageAuthor{runstest}

Maintainer: \packageMaintainer{runstest}
}
\references{
Tamhane, Ajit. "4.6.1: Tests for Independence." Predictive Analytics (I): Parametric Regression and Classification Models. N.p.: n.p., NOT YET PUBLISHED. N. pag. Print.
}
\keyword{ package }
\examples{
data(example)
linreg <- lm(H ~ P, data=example) 
runsTest(linreg)
}
