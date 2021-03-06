context("R62S3")

b <- Binomial$new()

test_that("SDistribution",{
  expect_true(isPdf(b))
  expect_true(isCdf(b))
  expect_true(isQuantile(b))
  expect_true(isRand(b))
  expect_null(decorators(b), NULL)
  expect_equal(sup(b), 10)
  expect_equal(dmax(b), 10)
  expect_equal(pdf(b, 1:5), b$pdf(1:5))
  expect_equal(mean(b), b$mean())
  expect_equal(mean.Distribution(b), b$mean())
  expect_equal(variance(b), b$variance())
  expect_equal(mgf(b, 1:2), b$mgf(1:2))
})

test_that("Distribution",{
  expect_equal(prec(b), b$prec())
})

test_that("kernel",{
  expect_equal(squared2Norm(Cosine$new()), Cosine$new()$squared2Norm())
})

p = b$parameters()
test_that("ParameterSet",{
  expect_equal(getParameterSupport(p, "size"), p$getParameterSupport("size"))
  expect_silent(setParameterValue(p, size = 10))
  expect_equal(getParameterValue(p, "size"), 10)
})

test_that("CoreStatistics",{
  expect_message(decorate(b, "CoreStatistics"))
  expect_equal(mean(b), b$mean())
  expect_equal(pgf(b, 2), b$pgf(2))
})

test_that("ExoticStatistics",{
  expect_message(decorate(b, "ExoticStatistics"))
  expect_equal(survival(b, 10), b$survival(10))
})
