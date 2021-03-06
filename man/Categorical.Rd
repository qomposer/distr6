% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SDistribution_Categorical.R
\name{Categorical}
\alias{Categorical}
\title{Categorical Distribution Class}
\value{
Returns an R6 object inheriting from class SDistribution.
}
\description{
Mathematical and statistical functions for the Categorical distribution, which
is commonly used in classification supervised learning.
}
\details{
The Categorical distribution parameterised with  a given support set, \eqn{x_1,...,x_k}, and respective probabilities, \eqn{p_1,...,p_k}, is defined by the pmf, \deqn{f(x_i) = p_i} for \eqn{p_i, i = 1,\ldots,k; \sum p_i = 1}.

The distribution is supported on \eqn{x_1,...,x_k}.

Only the mode, pdf, cdf, quantile and rand are available for this Distribution, all other methods return \code{NaN}. Sampling from this distribution is performed with the \code{\link[base]{sample}} function with the elements given as the support set and the probabilities from the \code{probs} parameter. The cdf and quantile assumes that the elements are supplied in an indexed order (otherwise the results are meaningless).
}
\section{Constructor}{
 Categorical$new(..., probs, decorators = NULL, verbose = FALSE)
}

\section{Constructor Arguments}{

\tabular{lll}{
\strong{Argument} \tab \strong{Type} \tab \strong{Details} \cr
\code{...} \tab ANY \tab elements in the support Set. See details. \cr
\code{probs} \tab numeric \tab vector of probabilities. See details. \cr

\code{decorators} \tab Decorator \tab decorators to add functionality. See details. \cr
\code{verbose} \tab logical \tab if TRUE parameterisation messages produced.
}
}

\section{Constructor Details}{
 The Categorical distribution is parameterised with a series of elements for the support set and \code{probs} determining the probability of each category occurring. The length of the probability list should equal the number of elements. The probability vector is automatically normalised with \deqn{probs = probs/sum(probs)} If no arguments are given, then defaults to one element '1' with probability one.
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
# Note probabilities are automatically normalised
x = Categorical$new("Bapple","Banana",2,probs=c(0.2,0.4,1))

# Only the probabilities can be changed and must the same length as in construction
x$setParameterValue(probs = c(0.1,0.2,0.7))

# d/p/q/r
x$pdf(c("Bapple", "Carrot", 1, 2))
x$cdf("Banana") # Assumes ordered in construction
x$quantile(0.42) # Assumes ordered in construction
x$rand(10)

# Statistics
x$mode()

summary(x)

}
\references{
McLaughlin, M. P. (2001). A compendium of common probability distributions (pp. 2014-01).
Michael P. McLaughlin.
}
\seealso{
\code{\link{listDistributions}} for all available distributions. \code{\link[base]{sample}} for the sampling function.
}
