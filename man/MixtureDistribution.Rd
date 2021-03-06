% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Wrapper_MixtureDistribution.R
\name{MixtureDistribution}
\alias{MixtureDistribution}
\title{Mixture Distribution Wrapper}
\value{
Returns an R6 object of class MixtureDistribution.
}
\description{
Wrapper used to construct a mixture of two or more distributions.
}
\details{
A Mixture Distribution is a weighted combination of two or more distributions such that for
pdf/cdfs of n distribution \eqn{f_1,...,f_n}/\eqn{F_1,...,F_n} and a given weight associated to each distribution,
\eqn{w_1,...,w_n}. The pdf of the mixture distribution \eqn{M(X1,...,XN)}, \eqn{f_M} is given by
\deqn{f_M = \sum_i (f_i)(w_i)}
and the cdf, F_M is given by
\deqn{F_M = \sum_i (F_i)(w_i)}

If weights are given, they should be provided as a vector of numerics. If they don't sum to one
then they are normalised automatically. If NULL, they are taken to be uniform, i.e. for n
distributions, \eqn{w_i = 1/n, \ \forall \ i \ \in \ [1,n]}{w_i = 1/n, for all i \epsilon [1,n]}.

Can optionally be constructed using a \code{VectorDistribution}, in which case \code{distlist} is ignored
and the mixture is constructed with the wrapped models in the vector.
}
\section{Constructor}{
 MixtureDistribution$new(distlist, weights = NULL, vectordist = NULL)
}

\section{Constructor Arguments}{

\tabular{lll}{
\strong{Argument} \tab \strong{Type} \tab \strong{Details} \cr
\code{distlist} \tab list \tab List of distributions. \cr
\code{weights} \tab numeric \tab Vector of weights. See Details. \cr
\code{vectordist} \tab numeric \tab Vector Distribution. See Details. \cr
}
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
\code{wrappedModels(model = NULL)} \tab \code{\link{wrappedModels}} \cr
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
\strong{d/p/q/r Methods} \tab \strong{Link} \cr
\code{pdf(x1, ..., log = FALSE, simplify = TRUE)} \tab \code{\link{pdf}} \cr
\code{cdf(x1, ..., lower.tail = TRUE, log.p = FALSE, simplify = TRUE)} \tab \code{\link{cdf}}\cr
\code{quantile(p, ..., lower.tail = TRUE, log.p = FALSE, simplify = TRUE)} \tab \code{\link{quantile.Distribution}} \cr
\code{rand(n, simplify = TRUE)} \tab \code{\link{rand}} \cr
\tab \cr \tab \cr \tab \cr
\strong{Statistical Methods} \tab \strong{Link} \cr
\code{prec()} \tab \code{\link{prec}} \cr
\code{stdev()} \tab \code{\link{stdev}}\cr
\code{median()} \tab \code{\link{median.Distribution}} \cr
\code{iqr()} \tab \code{\link{iqr}} \cr
\code{cor()} \tab \code{\link{cor}} \cr
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
mixture <- MixtureDistribution$new(list(Binomial$new(prob = 0.5, size = 10), Binomial$new()),
                                   weights = c(0.2,0.8))
mixture$pdf(1)
mixture$cdf(1)

}
\seealso{
\code{\link{listWrappers}}
}
