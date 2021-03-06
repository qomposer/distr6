% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SDistribution_Degenerate.R
\name{Degenerate}
\alias{Degenerate}
\alias{Dirac}
\alias{Delta}
\title{Degenerate Distribution Class}
\value{
Returns an R6 object inheriting from class SDistribution.
}
\description{
Mathematical and statistical functions for the Degenerate distribution, which
is commonly used to model deterministic events or as a representation of the delta, or Heaviside, function.
}
\details{
The Degenerate distribution parameterised with  mean, \eqn{\mu} is defined by the pmf, \deqn{f(x) = 1, \ if \ x = \mu}{f(x) = 1, if x = \mu}\deqn{f(x) = 0, \ if \ x \neq \mu}{f(x) = 0, if x != \mu} for \eqn{\mu \epsilon R}.

The distribution is supported on \eqn{{\mu}}.

Also known as the Dirac distribution.
}
\section{Constructor}{
 Degenerate$new(mean = 0, decorators = NULL, verbose = FALSE)
}

\section{Constructor Arguments}{

\tabular{lll}{
\strong{Argument} \tab \strong{Type} \tab \strong{Details} \cr
\code{mean} \tab numeric \tab location parameter. \cr

\code{decorators} \tab Decorator \tab decorators to add functionality. See details. \cr
\code{verbose} \tab logical \tab if TRUE parameterisation messages produced.
}
}

\section{Constructor Details}{
 The Degenerate distribution is parameterised with \code{mean} as a numeric.
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
x = Degenerate$new(mean = 4)

# Update parameters
x$setParameterValue(mean = 2.56)
x$parameters()

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
\code{\link{listDistributions}} for all available distributions.
}
