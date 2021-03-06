#' @name VectorDistribution
#' @title Vectorise Distributions
#' @description A wrapper for creating a vector of distributions.
#'
#' @details A vector distribution is intented to vectorize distributions more efficiently than storing
#' a list of distributions. To improve speed and reduce memory usage, distributions are only constructed
#' when methods (e.g. d/p/q/r) are called. Whilst it is recommended to first extract distributions
#' using `[` before querying them for results, all common methods are available in
#' `VectorDistribution` as they are wrapped in `apply`.
#'
#' @section Constructor: VectorDistribution$new(distlist = NULL, distribution = NULL, params = NULL,
#' name = NULL, short_name = NULL, description = NULL, decorators = NULL)
#'
#' @section Constructor Arguments:
#' \tabular{lll}{
#' \strong{Argument} \tab \strong{Type} \tab \strong{Details} \cr
#' \code{distlist} \tab list \tab List of distributions. \cr
#' \code{distribution} \tab character \tab Distribution to wrap. \cr
#' \code{params} \tab a R object \tab Either list of parameters or matrix-type frame, see examples. \cr
#' \code{shared_params} \tab a R object \tab Either list of shared parameters or matrix-type frame, see examples. \cr
#' \code{name} \tab list \tab Optional new name for distribution. \cr
#' \code{short_name} \tab list \tab Optional new short_name for distribution. \cr
#' \code{description} \tab list \tab Optional new description for distribution. \cr
#' \code{decorators} \tab list \tab Decorators to pass to wrapped distributions on construction. \cr
#' }
#'
#' @section Constructor Details: A vector distribution can either be constructed by a list of
#' distributions passed to \code{distlist} or by passing the name of one or more distributions
#' implemented in distr6 to \code{distribution}, as well as a list or table of parameters to \code{params}.
#' The former case provides more flexibility in the ability to use wrapped distributions
#' but the latter is vastly faster for distributions of class \code{SDistribution} or custom distributions.
#' The \code{shared_params} parameter decreases memory usage and improves speed by storing any parameters
#' shared between distributions only once (instead of repeated in a list).
#'
#' @inheritSection DistributionWrapper Public Variables
#' @inheritSection DistributionWrapper Public Methods
#'
#' @seealso \code{\link{listWrappers}} and \code{\link{ProductDistribution}}
#'
#' @return Returns an R6 object of class VectorDistribution.
#'
#' @examples
#' # not run to save time
#' \dontrun{
#' vecDist <- VectorDistribution$new(list(Binomial$new(prob = 0.5,
#'                            size = 10), Normal$new(mean = 15)))
#' vecDist$pdf(x1 = 2, x2 =3)
#' # Equivalently
#' vecDist[1]$pdf(2); vecDist[2]$pdf(3)
#' # Or to evaluate every distribution at the same point
#' vecDist$pdf(1)
#'
#' # Same wrapping for statistical functions
#' vecDist$mean()
#' c(vecDist[1]$mean(), vecDist[2]$mean())
#' vecDist$entropy()
#' c(vecDist[1]$entropy(), vecDist[2]$entropy())
#'
#' vecDist$cdf(1:5, 12:16)
#' vecDist$rand(10)
#'
#' vecBin = VectorDistribution$new(distribution = "Binomial",
#'        params = list(list(prob = 0.1, size = 2),
#'                    list(prob = 0.6, size = 4),
#'                    list(prob = 0.2, size = 6)))
#' vecBin$pdf(x1=1,x2=2,x3=3)
#' vecBin$cdf(x1=1,x2=2,x3=3)
#' vecBin$rand(10)
#'
#' #Equivalently
#' vecBin = VectorDistribution$new(distribution = "Binomial",
#'        params = data.table::data.table(prob = c(0.1,0.6,0.2), size = c(2,4,6)))
#' vecBin$pdf(x1=1,x2=2,x3=3)
#' vecBin$cdf(x1=1,x2=2,x3=3)
#' vecBin$rand(10)
#'
#' # sharedparams is very useful for vectorized custom distributions
#' shared_params = list(name = "A Distribution", short_name = "Dist", type = Reals$new())
#' params = list(list(pdf = function(x) return(1)), list(pdf = function(x) return(2)))
#' vecdist = VectorDistribution$new(distribution = "Distribution", params = params,
#'                                    shared_params = shared_params)
#' vecdist$pdf(1)
#' }
#'
#' @export
NULL
VectorDistribution <- R6Class("VectorDistribution", inherit = DistributionWrapper, lock_objects = FALSE)
.distr6$wrappers <- append(.distr6$wrappers, list(VectorDistribution = VectorDistribution))

VectorDistribution$set("public","initialize",function(distlist = NULL, distribution = NULL, params = NULL,
                                                      shared_params = NULL, name = NULL, short_name = NULL, description = NULL,
                                                      decorators = NULL){

  if(!is.null(decorators)) {
    suppressMessages(decorate(self, decorators))
  }

  if(is.null(distlist)){
    if(is.null(distribution) | (is.null(params) & is.null(shared_params)))
      stop("Either distlist or distribution and shared_params/params must be provided.")

    # assumes distribution is a character
    if(!(any(distribution %in% c(listDistributions(simplify = T), "Distribution"))))
      stop(paste(distribution, "is not currently implemented in distr6. See listDistributions()."))

    if(is.null(params)){
      params <- list()
    } else {
      if(!checkmate::testList(params))  params = apply(params, 1, as.list)
      if(!checkmate::testList(params[[1]])) params = lapply(params, list)
    }
    if(is.null(shared_params)){
      shared_params <- list()
    } else {
      if(!checkmate::testList(shared_params))  shared_params = as.list(shared_params)
    }


    if("short_name" %in% names(shared_params))
      shortname = shared_params$short_name
    else {
      shortname = character(length(params))
      shortname[distribution %in% "Distribution"] = sapply(params[distribution %in% "Distribution"],
                                                           function(x) x$short_name)
      shortname[!(distribution %in% "Distribution")] = sapply(distribution[!(distribution %in% "Distribution")],
                                                              function(x) get(x)$public_fields$short_name)
      shortname = unlist(shortname)
    }

    private$.wrappedModels = data.table::data.table(distribution = distribution, params = params,
                                                    shortname = shortname)
    private$.sharedparams = shared_params

    if(length(unique(distribution)) == 1)
      distribution = rep(distribution, length(params))

  } else {
    shortname = c()
    distribution = c()

    for(i in 1:length(distlist)){
      shortname = c(shortname, distlist[[i]]$short_name)
      distribution = c(distribution, distlist[[i]]$name)
      distlist[[i]] = distlist[[i]]$clone(deep = TRUE)
    }

    private$.wrappedModels = data.table::data.table(distribution = distlist, params = NA,
                                                    shortname = shortname)
    private$.distlist = TRUE
  }

  ndist = nrow(private$.wrappedModels)

  if(length(unique(distribution)) == 1){
    if(is.null(name)) name = paste0("Vector: ", ndist," ", distribution[[1]],"s")
    if(is.null(short_name)) short_name = paste0("Vec", ndist, private$.wrappedModels[1, 3][[1]])
  } else{
    if(is.null(name)) name = paste("Vector:",paste0(distribution, collapse=", "))
    if(is.null(short_name)) short_name = paste0(private$.wrappedModels[,"shortname"][[1]], collapse="Vec")
  }

  private$.wrappedModels[,3] <- makeUniqueNames(private$.wrappedModels[,3][[1]])

  lst <- rep(list(bquote()), ndist)
  names(lst) <- paste("x",1:ndist,sep="")

  pdf = function() {}
  formals(pdf) = lst
  body(pdf) = substitute({
    pdfs = NULL
    if(class(try(get("x2"), silent = T)) == "try-error"){
      for(i in 1:n)
        pdfs = c(pdfs, self[i]$pdf(get("x1")))
    } else {
      for(i in 1:n)
        pdfs = c(pdfs, self[i]$pdf(get(paste0("x",i))))
    }
    y = data.table::data.table(matrix(pdfs, ncol = n))
    colnames(y) <- unlist(private$.wrappedModels[,3])
    return(y)
  },list(n = ndist))

  cdf = function() {}
  formals(cdf) = lst
  body(cdf) = substitute({
    cdfs = NULL
    if(class(try(get("x2"), silent = T)) == "try-error"){
      for(i in 1:n)
        cdfs = c(cdfs, self[i]$cdf(get("x1")))
    } else {
      for(i in 1:n)
        cdfs = c(cdfs, self[i]$cdf(get(paste0("x",i))))
    }
    y = data.table::data.table(matrix(cdfs, ncol = n))
    colnames(y) <- unlist(private$.wrappedModels[,3])
    return(y)
  },list(n = ndist))

  quantile = function() {}
  formals(quantile) = lst
  body(quantile) = substitute({
    quantiles = NULL
    if(class(try(get("x2"), silent = T)) == "try-error"){
      for(i in 1:n)
        quantiles = c(quantiles, self[i]$quantile(get("x1")))
    } else {
      for(i in 1:n)
        quantiles = c(quantiles, self[i]$quantile(get(paste0("x",i))))
    }
    y = data.table::data.table(matrix(quantiles, ncol = n))
    colnames(y) <- unlist(private$.wrappedModels[,3])
    return(y)
  },list(n = ndist))

  rand = function(n) {
    rand <- sapply(1:nrow(private$.wrappedModels), function(x) self[x]$rand(n))
    if(n == 1) rand <- t(rand)
    rand <- data.table::as.data.table(rand)
    colnames(rand) <- unlist(private$.wrappedModels[,3])
    return(rand)
  }

  type = setpower(Reals$new(), ndist)
  support = setpower(Reals$new(), ndist)

  super$initialize(pdf = pdf, cdf = cdf, quantile = quantile, rand = rand, name = name,
                   short_name = short_name, description = description, support = support,
                   type = type, variateForm = "multivariate", valueSupport = "mixture",
                   suppressMoments = TRUE)
})
VectorDistribution$set("public","wrappedModels", function(model = NULL){
  if(is.null(model)){
    if (private$.distlist)
      return(private$.wrappedModels[, "distribution"][[1]])
    else
      return(apply(private$.wrappedModels, 1, function(x) do.call(get(x[[1]])$new, x[[2]])))
  } else {
    model = model[model %in% private$.wrappedModels[, "shortname"][[1]]]

    if(length(model) == 0)
      return(self$wrappedModels())

    if (private$.distlist) {
      x = subset(private$.wrappedModels, shortname %in% model, distribution)
      if(nrow(x) == 1)
        return(x[[1]][[1]])
      else{
        x = unlist(as.list(x), recursive = TRUE)
        names(x) = model
        return(x)
      }
    } else{
      x = subset(private$.wrappedModels, shortname %in% model)
      x = apply(x, 1, function(y) do.call(get(y[[1]])$new, y[[2]]))
      if(length(x) == 1)
        return(x[[1]])
    }
  }
})
VectorDistribution$set("active","modelTable", function(){
  private$.wrappedModels
})

VectorDistribution$set("public", "strprint", function(n = 100){
  names <- as.character(self$modelTable$shortname)
  lng <- length(names)
  if(lng >(2*n))
    names = c(names[1:n], "...", names[(lng-n+1):lng])

  return(names)
})
VectorDistribution$set("public", "getParameterValue", function(...){
  message("Vector Distribution should not be used to get/set parameters. Try to use '[' first.")
  return(NULL)
})
VectorDistribution$set("public", "setParameterValue", function(...){
  message("Vector Distribution should not be used to get/set parameters. Try to use '[' first.")
  return(NULL)
})
VectorDistribution$set("public", "parameters", function(...){
  message("Vector Distribution should not be used to get/set parameters. Try to use '[' first.")
  return(data.table::data.table())
})

VectorDistribution$set("public", "mean", function(){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$mean(), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "mode", function(which = "all"){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$mode(which), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "variance", function(){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$variance(), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "skewness", function(){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$skewness(), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "kurtosis", function(excess = TRUE){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$kurtosis(excess), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "entropy", function(base = 2){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$entropy(base), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "mgf", function(t){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$mgf(t), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "cf", function(t){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$cf(t), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
VectorDistribution$set("public", "pgf", function(z){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$pgf(z), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})

VectorDistribution$set("active", "distlist", function() return(private$.distlist))
VectorDistribution$set("active", "shared_params", function() return(private$.sharedparams))

VectorDistribution$set("private", ".distlist", FALSE)
VectorDistribution$set("private", ".sharedparams", list())

#' @title Extract one or more Distributions from a VectorDistribution
#' @description Once a \code{VectorDistribution} has been constructed, use \code{[}
#' to extract one or more \code{Distribution}s from inside it.
#' @param vecdist VectorDistribution from which to extract Distributions.
#' @param i indices specifying distributions to extract.
#' @export
Extract.VectorDistribution <- function(vecdist, i){
  i = i[i %in% (1:nrow(vecdist$modelTable))]
  if(length(i) == 0)
    stop("Index i too large, should be less than or equal to ", nrow(vecdist$modelTable))

  if(!vecdist$distlist){
    if(length(i) == 1){
      par = c(vecdist$modelTable[i, 2][[1]][[1]], vecdist$shared_params)

      # if(!checkmate::testList(par))
      #   par = list(par)

      dec = vecdist$decorators
      if(!is.null(dec))
        par = c(par, list(decorators = dec))

      return(do.call(get(vecdist$modelTable[i, 1][[1]])$new, par))

    }else
      return(VectorDistribution$new(distribution = vecdist$modelTable[i, 1][[1]],
                                    params = vecdist$modelTable[i, 2][[1]]))
  } else {
    if(length(i) == 1){
      dec = vecdist$decorators
      if(!is.null(dec)) {
        dist = vecdist$modelTable[i, 1][[1]][[1]]
        suppressMessages(decorate(dist, dec))
        return(dist)
      } else
        return(vecdist$modelTable[i, 1][[1]][[1]])
    } else
      return(VectorDistribution$new(distlist = unlist(vecdist$modelTable[i, 1])))
  }
}

#' @rdname Extract.VectorDistribution
#' @usage \method{[}{VectorDistribution}(vecdist, i)
#' @export
'[.VectorDistribution' <- function(vecdist, i){
  Extract.VectorDistribution(vecdist, i)
}

