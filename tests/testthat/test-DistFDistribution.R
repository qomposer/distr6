library(testthat)

context("FDistribution")

test_that("parameterisation", {
  expect_silent(FDistribution$new())
  expect_silent(FDistribution$new(df1 = 3, df2 = 5))
  expect_error(FDistribution$new(df1 = 1, df2 = -1))
  expect_error(FDistribution$new(df1 = -1, df2 = 1))
  expect_equal(FDistribution$new(df1 = 10, df2 = 5)$getParameterValue("df1"), 10)
  expect_equal(FDistribution$new(df1 = 10, df2 = 5)$getParameterValue("df2"), 5)
  expect_equal(FDistribution$new(df1 = 8.1, df2 = 3.6)$getParameterValue("df1"), 8.1)
  expect_equal(FDistribution$new(df1 = 8.1, df2 = 3.6)$getParameterValue("df2"), 3.6)
})

test_that("properties & traits", {
  expect_equal(FDistribution$new()$valueSupport, "continuous")
  expect_equal(FDistribution$new()$variateForm, "univariate")
  expect_equal(FDistribution$new()$symmetry, "asymmetric")
  expect_equal(FDistribution$new()$sup, Inf)
  expect_equal(FDistribution$new()$inf, 0)
  expect_equal(FDistribution$new()$dmax, Inf)
  expect_equal(FDistribution$new()$dmin, 0)
  expect_equal(FDistribution$new(df1 = 5, df2 = 5)$dmax, Inf)
  expect_equal(FDistribution$new(df1 = 5, df2 = 5)$dmin, .Machine$double.eps)
})

f1 <- FDistribution$new(df1 = 4)
f2 <- FDistribution$new(df1 = 2, df2 = 10)
test_that("statistics", {
  expect_equal(f1$mean(), NaN)
  expect_equal(f2$mean(), 1.25)
  expect_equal(f1$variance(), NaN)
  expect_equal(round(f2$variance(), 5), 2.60417)
  expect_equal(f1$skewness(), NaN)
  expect_equal(round(f2$skewness(), 5), 4.64758)
  expect_equal(f1$kurtosis(), NaN)
  expect_equal(f1$kurtosis(FALSE), NaN)
  expect_equal(f2$kurtosis(TRUE), 70.8)
  expect_equal(f2$kurtosis(FALSE), 73.8)
  expect_equal(f1$mgf(5), NaN)
  expect_equal(f1$pgf(1), NaN)
  expect_error(f1$cf(1))
  expect_equal(f1$mode(), 1/6)
  expect_equal(f2$mode(), NaN)
  expect_equal(round(f1$entropy(exp(1)), 5), 2.45435)
  expect_equal(f1$pdf(2), df(2, 4, 1))
  expect_equal(f2$cdf(1.5), pf(1.5, 2, 10))
  expect_equal(f1$quantile(0.5), qf(0.5, 4, 1))
  expect_equal(f2$cdf(f2$quantile(0.12345)), 0.12345)
  expect_silent(f1$rand(10))
})
