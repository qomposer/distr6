#' @include SetInterval_SpecialSet.R ParameterSet.R
#-------------------------------------------------------------
# Logistic Distribution Documentation
#-------------------------------------------------------------
#' @title Logistic Distribution
#'
#' @description Mathematical and statistical functions for the Logistic distribution parameterised
#' with mean (location) and scale.
#'
#' @name Logistic
#'
#' @section Constructor: Logistic$new(mean = 0, scale = 1, decorators = NULL, verbose = FALSE)
#'
#' @section Constructor Arguments:
#' \tabular{lll}{
#' \strong{Argument} \tab \strong{Type} \tab \strong{Details} \cr
#' \code{mean} \tab numeric \tab location parameter. \cr
#' \code{scale} \tab numeric \tab scale parameter. \cr
#' \code{decorators} \tab Decorator \tab decorators to add functionality. \cr
#' \code{verbose} \tab logical \tab if TRUE parameterisation messages produced.
#' }
#'
#' @section Constructor Details: The Laplace distribution is parameterised with mean and
#' scale. The default parameterisation is with mean 0 and scale 1.
#'
#' @inheritSection SDistribution Public Variables
#' @inheritSection SDistribution Public Methods
#'
#' @export
NULL
#-------------------------------------------------------------
# Logistic Distribution Definition
#-------------------------------------------------------------
Logistic <- R6::R6Class("Logistic", inherit = SDistribution, lock_objects = F)
Logistic$set("public","name","Logistic")
Logistic$set("public","short_name","Logis")
Logistic$set("public","traits",list(type = Reals$new(),
                                  valueSupport = "continuous",
                                  variateForm = "univariate"))
Logistic$set("public","description","Logistic Probability Distribution.")
Logistic$set("public","package","stats")

Logistic$set("public","mean",function(){
  return(self$getParameterValue("mean"))
})
Logistic$set("public","var",function(){
  return((self$getParameterValue("scale")^2)*(pi^2)/3)
})
Logistic$set("public","skewness",function(){
  return(0)
})
Logistic$set("public","kurtosis",function(excess = TRUE){
  if(excess)
    return(6/5)
  else
    return(6/5 + 3)
})
Logistic$set("public","entropy",function(base = 2){
  return(2 + log(self$getParameterValue("scale"), base))
})
Logistic$set("public", "mgf", function(t){
  if (-1/self$getParameterValue("scale") < t & t < 1/self$getParameterValue("scale"))
    return(exp(self$getParameterValue("mean") * t) * beta(1-self$getParameterValue("scale")*t, 1+self$getParameterValue("scale")*t))
  else
    return(NaN)
})
Logistic$set("public", "cf", function(t){
  return(exp(1i*self$getParameterValue("mean")*t) *
           (self$getParameterValue("scale")*pi*t)/(sinh(pi*self$getParameterValue("scale")*t)))
})
Logistic$set("public","mode",function(){
  return(self$getParameterValue("mean"))
})

Logistic$set("private",".getRefParams", function(paramlst){
  lst = list()
  if(!is.null(paramlst$mean)) lst = c(lst, list(mean = paramlst$mean))
  if(!is.null(paramlst$scale)) lst = c(lst, list(scale = paramlst$scale))
  return(lst)
})

Logistic$set("public","initialize",function(mean = 0, scale = 1,
                                          decorators = NULL, verbose = FALSE){

  private$.parameters <- getParameterSet(self, mean, scale, verbose)
  self$setParameterValue(list(mean = mean, scale = scale))

  pdf <- function(x1) dlogis(x1, self$getParameterValue("mean"), self$getParameterValue("scale"))
  cdf <- function(x1) plogis(x1, self$getParameterValue("mean"), self$getParameterValue("scale"))
  quantile <- function(p) qlogis(p, self$getParameterValue("mean"), self$getParameterValue("scale"))
  rand <- function(n) rlogis(n, self$getParameterValue("mean"), self$getParameterValue("scale"))

  super$initialize(decorators = decorators, pdf = pdf, cdf = cdf, quantile = quantile,
                   rand = rand, support = Reals$new(), distrDomain = Reals$new(),
                   symmetric = TRUE)
  invisible(self)
})