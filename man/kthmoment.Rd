% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DistributionDecorator_CoreStatistics.R
\name{kthmoment}
\alias{kthmoment}
\title{Kth Moment}
\usage{
kthmoment(object, k, type = "central")
}
\arguments{
\item{object}{Distribution.}

\item{k}{the kth moment to calculate}

\item{type}{one of 'central', 'standard' or 'raw', abbreviations allowed}
}
\value{
If univariate, the given k-moment as a numeric, otherwise NULL.
}
\description{
Kth standardised or central moment of a distribution
}
\details{
The kth central moment of a distribution is defined by
\deqn{CM(k)_X = E_X[(x - \mu)^k]}
the kth standardised moment of a distribution is defined by
\deqn{SM(k)_X = \frac{CM(k)}{\sigma^k}}{SM(k)_X = CM(k)/\sigma^k}
the kth raw moment of a distribution is defined by
\deqn{RM(k)_X = E_X[x^k]}
where \eqn{E_X} is the expectation of distribution X, \eqn{\mu} is the mean of the distribution and \eqn{\sigma} is the
standard deviation of the distribution.

Abbreviations for the type are allowed but if an unfamiliar input is given then the central moment
is computed.

Can only be used after decorating with \code{\link{CoreStatistics}}.
}
\section{R6 Usage}{
 $kthmoment(k, type = "central")
}

\seealso{
\code{\link{CoreStatistics}} and \code{\link{decorate}}
}
