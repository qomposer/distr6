% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assertions.R
\name{testLeptokurtic}
\alias{testLeptokurtic}
\alias{checkLeptokurtic}
\alias{assertLeptokurtic}
\title{assert/check/test/Leptokurtic}
\usage{
testLeptokurtic(
  object,
  errormsg = paste(object$short_name, "is not leptokurtic")
)

checkLeptokurtic(
  object,
  errormsg = paste(object$short_name, "is not leptokurtic")
)

assertLeptokurtic(
  object,
  errormsg = paste(object$short_name, "is not leptokurtic")
)
}
\arguments{
\item{object}{Distribution}

\item{errormsg}{custom error message to return if assert/check fails}
}
\value{
If check passes then \code{assert} returns invisibly and \code{test}/\code{check}
return \code{TRUE}. If check fails, \code{assert} stops code with error, \code{check} returns
an error message as string, \code{test} returns \code{FALSE}.
}
\description{
Validation checks to test if Distribution is leptokurtic.
}
\examples{
testLeptokurtic(Binomial$new())

}
