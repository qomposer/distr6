Vec_ExoticStatistics <- R6::R6Class("Vec_ExoticStatistics", inherit = DistributionDecorator)
Vec_ExoticStatistics$set("public", "cdfAntiDeriv", function(lower = NULL, upper = NULL){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$cdfAntiDeriv(lower, upper), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
Vec_ExoticStatistics$set("public", "survivalAntiDeriv", function(lower = NULL, upper = NULL) {
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$survivalAntiDeriv(lower, upper), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
Vec_ExoticStatistics$set("public", "survival", function(..., log = FALSE) {
  x = NULL
  if(...length() == 1){
    for(i in 1:nrow(private$.wrappedModels))
      x = c(x, self[i]$survival(...elt(1), log = log))
  } else {
    for(i in 1:nrow(private$.wrappedModels))
      x = c(x, self[i]$survival(...elt(i), log = log))
  }
  y = data.table::data.table(matrix(x, ncol = nrow(private$.wrappedModels)))
  colnames(y) <- unlist(private$.wrappedModels[,3])
  return(y)
})
Vec_ExoticStatistics$set("public", "hazard", function(x1, log = FALSE) {
  x = NULL
  if(class(try(get("x2"), silent = T)) == "try-error"){
    for(i in 1:nrow(private$.wrappedModels))
      x = c(x, self[i]$hazard(get("x1"), log = log))
  } else {
    for(i in 1:nrow(private$.wrappedModels))
      x = c(x, self[i]$hazard(get(paste0("x",i)), log = log))
  }
  y = data.table::data.table(matrix(x, ncol = nrow(private$.wrappedModels)))
  colnames(y) <- unlist(private$.wrappedModels[,3])
  return(y)
})
Vec_ExoticStatistics$set("public", "cumHazard", function(x1, log = FALSE) {
  x = NULL
  if(class(try(get("x2"), silent = T)) == "try-error"){
    for(i in 1:nrow(private$.wrappedModels))
      x = c(x, self[i]$cumHazard(get("x1"), log = log))
  } else {
    for(i in 1:nrow(private$.wrappedModels))
      x = c(x, self[i]$cumHazard(get(paste0("x",i)), log = log))
  }
  y = data.table::data.table(matrix(x, ncol = nrow(private$.wrappedModels)))
  colnames(y) <- unlist(private$.wrappedModels[,3])
  return(y)
})

Vec_ExoticStatistics$set("public", "cdfPNorm", function(p = 2, lower = NULL, upper = NULL) {
  if(is.null(lower)) lower <- self$inf()
  if(is.null(upper)) upper <- self$sup()

  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$cdfPNorm(p, lower, upper), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
Vec_ExoticStatistics$set("public", "pdfPNorm", function(p = 2, lower = NULL, upper = NULL) {
  if(is.null(lower)) lower <- self$inf()
  if(is.null(upper)) upper <- self$sup()

  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$pdfPNorm(p, lower, upper), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
Vec_ExoticStatistics$set("public","squared2Norm",function(lower = NULL, upper = NULL){
  return(self$pdfPNorm(p = 2, lower = lower, upper = upper))
})
Vec_ExoticStatistics$set("public", "survivalPNorm", function(p = 2, lower = NULL, upper = NULL){
  if(is.null(lower)) lower <- self$inf()
  if(is.null(upper)) upper <- self$sup()

  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$survivalPNorm(p, lower, upper), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
