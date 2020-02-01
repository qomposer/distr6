Vec_CoreStatistics <- R6::R6Class("Vec_CoreStatistics", inherit = DistributionDecorator)
Vec_CoreStatistics$set("public", "kthmoment", function(k, type = "central"){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$kthmoment(k, type), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})
Vec_CoreStatistics$set("public","genExp",function(trafo = NULL){
  ret = matrix(sapply(1:nrow(private$.wrappedModels), function(i)
    ifnerror(self[i]$genExp(trafo), error = NaN)), nrow = 1)
  colnames(ret) = unlist(private$.wrappedModels[,"shortname"])
  return(data.table::data.table(ret))
})

