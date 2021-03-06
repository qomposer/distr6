library(testthat)

context("c.Distribution")

test_that("non-distlist",{
  expect_error(c(Binomial$new(), Binomial), "One or more...")
  expect_silent(expect_length(c(Binomial, Binomial$new()), 2))
})

test_that("SDistributions",{
  expect_silent(c(Binomial$new(), Normal$new()))
  expect_equal(getR6Class(c(Binomial$new(), Normal$new())), "VectorDistribution")
  expect_equal(c(Binomial$new(), Normal$new())$short_name, "BinomVecNorm")
})

test_that("VectorDistributions",{
  v1 = VectorDistribution$new(list(Binomial$new(), Normal$new()))
  v2 = VectorDistribution$new(distribution = "Gamma", params  = data.table::data.table(shape = 1:2, rate = 1:2))
  expect_silent(c(v1, v2))
  expect_silent(c(v1, v2, Normal$new(), truncate(Binomial$new(), 2, 6)))
})

test_that("distribution/param VectorDistributions",{
  v1 = VectorDistribution$new(distribution = c("Binomial","Normal"),
                              params = list(list(size = 2), list(mean = 0, var = 2)))
  v2 = VectorDistribution$new(distribution = "Gamma", params  = data.table::data.table(shape = 1:2, rate = 1:2))
  expect_silent(c(v1, v2))
  v3 = c(v1, v2)
  expect_false(v3$distlist)
  expect_equal(v3$modelTable$distribution, c("Binomial","Normal","Gamma","Gamma"))
  expect_equal(v3$modelTable$shortname, c("Binom1","Norm1","Gamma1","Gamma2"))
  expect_equal(v3$modelTable$params, list(list(size = 2), list(mean = 0, var = 2),
                                            list(shape = 1, rate = 1), list(shape = 2, rate = 2)))
})

test_that("weighteddiscrete vec",{
  v1 = VectorDistribution$new(distribution = "WeightedDiscrete",
                              params = list(data = data.frame(x = 1, pdf = 1),
                                            data = data.frame(x = 2, pdf = 1)))
  v2 = VectorDistribution$new(distribution = "WeightedDiscrete",
                              params = list(data = data.frame(x = 3, pdf = 1),
                                            data = data.frame(x = 4, pdf = 1)))
  expect_silent(c(v1, v2))
})

test_that("different lengths",{
  v1 = VectorDistribution$new(distribution = "WeightedDiscrete",
                              params = list(list(data = data.frame(x = 1, pdf = 1),
                                            data = data.frame(x = 2, pdf = 1))))
  v2 = VectorDistribution$new(distribution = "WeightedDiscrete",
                              params = list(data = data.frame(x = 3, pdf = 1),
                                            data = data.frame(x = 4, pdf = 1)))
  expect_silent(c(v1, v2))
})
