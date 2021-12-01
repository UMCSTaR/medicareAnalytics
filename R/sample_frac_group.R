#' Sample by a proportion of a grouping variable
#' @details when the data is too big, we sample the data (usually
#      based on id_physician_npi) to get a smaller sample size to build models
#'
#' @param data A data frame.
#' @param proportion A value between 0 and 1.
#' @param id The bare column name containing the grouping variable whose labels you wish to sample.
#'
#' @return A filtered data frame containing roughly the proportion of id labels provided.
#' @export
#'

sample_frac_group <- function(data, proportion = .10, id = id_physician_npi, seed = 1234) {
  
  if (! (proportion > 0 & proportion < 1)) stop('Need valid proportion.')
  
  require(dplyr)
  
  id = enquo(id)
  
  ids = unique(pull(data, !!id))
  
  set.seed(seed)                 
  sample_ids = sample(ids, size = floor(proportion*length(ids)))
  
  filter(data, !!id %in% sample_ids)
}