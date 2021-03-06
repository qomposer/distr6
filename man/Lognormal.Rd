% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SDistribution_Lognormal.R
\name{Lognormal}
\alias{Lognormal}
\alias{Loggaussian}
\title{Log-Normal Distribution Class}
\value{
Returns an R6 object inheriting from class SDistribution.
}
\description{
Mathematical and statistical functions for the Log-Normal distribution, which
is commonly used to model many natural phenomena as a result of growth driven by small percentage changes.
}
\details{
The Log-Normal distribution parameterised with  logmean, \eqn{\mu}, and logvar, \eqn{\sigma}, is defined by the pdf, \deqn{exp(-(log(x)-\mu)^2/2\sigma^2)/(x\sigma\sqrt(2\pi))} for \eqn{\mu \epsilon R} and \eqn{\sigma > 0}.

The distribution is supported on the Positive Reals.

\code{cf}
is
omitted as no closed form analytic expression could be found, decorate with \code{\link{CoreStatistics}} for numerical results.

Also known as the Log-Gaussian distribution.
}
\section{Constructor}{
 Lognormal$new(meanlog = 0, varlog = 1, sdlog = NULL, preclog = NULL, mean = 1, var = NULL, sd = NULL, prec = NULL, decorators = NULL, verbose = FALSE)
}

\section{Constructor Arguments}{

\tabular{lll}{
\strong{Argument} \tab \strong{Type} \tab \strong{Details} \cr
\code{meanlog} \tab numeric \tab mean of the distribution on the log scale. \cr
\code{varlog} \tab numeric \tab variance of the distribution on the log scale. \cr
\code{sdlog} \tab numeric \tab standard deviation of the distribution on the log scale. \cr
\code{preclog} \tab numeric \tab precision of the distribution on the log scale. \cr
\code{mean} \tab numeric \tab mean of the distribution on the natural scale. \cr
\code{var} \tab numeric \tab variance of the distribution on the natural scale. \cr
\code{sd} \tab numeric \tab standard deviation of the distribution on the natural scale. \cr
\code{prec} \tab numeric \tab precision of the distribution on the natural scale. \cr

\code{decorators} \tab Decorator \tab decorators to add functionality. See details. \cr
\code{verbose} \tab logical \tab if TRUE parameterisation messages produced.
}
}

\section{Constructor Details}{
 The Log-Normal distribution is parameterised with either \code{meanlog} and \code{varlog}, \code{sdlog} or \code{preclog}, or \code{mean} and \code{var}, \code{sd} or \code{prec}. These are related via \deqn{var = (exp(var) - 1)) * exp(2 * meanlog + varlog)} \deqn{sdlog = varlog^2} \deqn{sd = var^2} Analogously for \code{prec} and \code{preclog}. If \code{prec} is given then all other parameters other than \code{mean} are ignored. If \code{sd} is given then all other parameters (except \code{prec}) are ignored. If \code{var} is given then all log parameters are ignored. If \code{preclog} is given then \code{varlog} and \code{sdlog} are ignored. Finally if \code{sdlog} is given then \code{varlog} is ignored.
}

\section{Public Variables}{

\tabular{ll}{
\strong{Variable} \tab \strong{Return} \cr
\code{name} \tab Name of distribution. \cr
\code{short_name} \tab Id of distribution. \cr
\code{description} \tab Brief description of distribution. \cr
\code{package} \tab The package d/p/q/r are implemented in.
}
}

\section{Public Methods}{

\tabular{ll}{
\strong{Accessor Methods} \tab \strong{Link} \cr
\code{decorators} \tab \code{\link{decorators}} \cr
\code{traits} \tab \code{\link{traits}} \cr
\code{valueSupport} \tab \code{\link{valueSupport}} \cr
\code{variateForm} \tab \code{\link{variateForm}} \cr
\code{type} \tab \code{\link{type}} \cr
\code{properties} \tab \code{\link{properties}} \cr
\code{support} \tab \code{\link{support}} \cr
\code{symmetry} \tab \code{\link{symmetry}} \cr
\code{sup}  \tab \code{\link{sup}} \cr
\code{inf} \tab \code{\link{inf}} \cr
\code{dmax}  \tab \code{\link{dmax}} \cr
\code{dmin} \tab \code{\link{dmin}} \cr
\code{skewnessType} \tab \code{\link{skewnessType}} \cr
\code{kurtosisType} \tab \code{\link{kurtosisType}} \cr

\tab \cr \tab \cr \tab \cr

\strong{Statistical Methods} \tab \strong{Link} \cr
\code{pdf(x1, ..., log = FALSE, simplify = TRUE)} \tab \code{\link{pdf}} \cr
\code{cdf(x1, ..., lower.tail = TRUE, log.p = FALSE, simplify = TRUE)} \tab \code{\link{cdf}}\cr
\code{quantile(p, ..., lower.tail = TRUE, log.p = FALSE, simplify = TRUE)} \tab \code{\link{quantile.Distribution}} \cr
\code{rand(n, simplify = TRUE)} \tab \code{\link{rand}} \cr
\code{mean()} \tab \code{\link{mean.Distribution}} \cr
\code{variance()} \tab \code{\link{variance}} \cr
\code{stdev()} \tab \code{\link{stdev}} \cr
\code{prec()} \tab \code{\link{prec}} \cr
\code{cor()} \tab \code{\link{cor}} \cr
\code{skewness()} \tab \code{\link{skewness}} \cr
\code{kurtosis(excess = TRUE)} \tab \code{\link{kurtosis}} \cr
\code{entropy(base = 2)} \tab \code{\link{entropy}} \cr
\code{mgf(t)} \tab \code{\link{mgf}} \cr
\code{cf(t)} \tab \code{\link{cf}} \cr
\code{pgf(z)} \tab \code{\link{pgf}} \cr
\code{median()} \tab \code{\link{median.Distribution}} \cr
\code{iqr()} \tab \code{\link{iqr}} \cr
\code{mode(which = "all")} \tab \code{\link{mode}} \cr

\tab \cr \tab \cr \tab \cr

\strong{Parameter Methods} \tab \strong{Link} \cr
\code{parameters(id)} \tab \code{\link{parameters}} \cr
\code{getParameterValue(id, error = "warn")}  \tab \code{\link{getParameterValue}} \cr
\code{setParameterValue(..., lst = NULL, error = "warn")} \tab \code{\link{setParameterValue}} \cr

\tab \cr \tab \cr \tab \cr

\strong{Validation Methods} \tab \strong{Link} \cr
\code{liesInSupport(x, all = TRUE, bound = FALSE)} \tab \code{\link{liesInSupport}} \cr
\code{liesInType(x, all = TRUE, bound = FALSE)} \tab \code{\link{liesInType}} \cr

\tab \cr \tab \cr \tab \cr

\strong{Representation Methods} \tab \strong{Link} \cr
\code{strprint(n = 2)} \tab \code{\link{strprint}} \cr
\code{print(n = 2)} \tab \code{\link[base]{print}} \cr
\code{summary(full = T)} \tab \code{\link{summary.Distribution}} \cr
}
}

\examples{
# Many parameterisations are possible
Lognormal$new(var = 2, mean = 1)
Lognormal$new(meanlog = 2, preclog = 5)
# Note parameters must be on same scale (log or natural)
Lognormal$new(meanlog = 4, sd = 2)

x <- Lognormal$new(verbose = TRUE) # meanlog = 0, sdlog = 1 default

# Update parameters
# When any parameter is updated, all others are too!
x$setParameterValue(meanlog = 3)
x$parameters()

# But you can only set parameters on the same scale, the below has no effect
x$setParameterValue(sd = 3)
# But this does
x$setParameterValue(sdlog = 3)

# d/p/q/r
x$pdf(5)
x$cdf(5)
x$quantile(0.42)
x$rand(4)

# Statistics
x$mean()
x$variance()

summary(x)

}
\references{
McLaughlin, M. P. (2001). A compendium of common probability distributions (pp. 2014-01).
Michael P. McLaughlin.
}
\seealso{
\code{\link{listDistributions}} for all available distributions. \code{\link{Normal}} for the Normal distribution. \code{\link{CoreStatistics}} for numerical results.
}
