% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DistributionDecorator_CoreStatistics.R
\name{variance}
\alias{variance}
\title{Distribution Variance}
\usage{
variance(object)
}
\arguments{
\item{object}{Distribution.}
}
\value{
Variance as a numeric.
}
\description{
The variance or covariance of a distribution, either calculated analytically if
or estimated numerically.
}
\details{
The variance of a distribution is defined by the formula
\deqn{var_X = E[X^2] - E[X]^2}
where \eqn{E_X} is the expectation of distribution X. If the distribution is multivariate the
covariance matrix is returned.

If an analytic expression isn't available, returns error. To impute a numerical expression, use the
\code{\link{CoreStatistics}} decorator.
}
\section{R6 Usage}{
 $variance()
}

\seealso{
\code{\link{CoreStatistics}}, \code{\link{decorate}} and \code{\link{genExp}}.
}
