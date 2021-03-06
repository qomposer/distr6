% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Distribution.R
\name{stdev}
\alias{stdev}
\title{Standard Deviation of a Distribution}
\usage{
stdev(object)
}
\arguments{
\item{object}{Distribution.}
}
\value{
Square-root of variance as a numeric.
}
\description{
Standard deviation of a distribution assuming variance is provided.
}
\details{
The standard deviation is analytically computed as the square root of the variance.
If the variance is not found in the distribution (analytically or numerically), returns error.
}
\section{R6 Usage}{
 $stdev()
}

\seealso{
\code{\link{variance}}
}
