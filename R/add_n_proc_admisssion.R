#' add_n_proc_admission
#' @description Add new variable "n_cpt_admission" to indicate number of CPTs in one hospital admission
#'     using member_id, facility claim admission and discharge dates
#'
#' @param data medicare data
#'
#' @rawNamespace import(data.table, except=c(last, first, between))
#'
#' @return medicare analytic file with one additional variable "n_cpt_admission".
#' @export

add_n_proc_admission <- function(data) {

  # check and set data.table
  if (is.data.table(data)) {
    setDT(data)
  }

  # add new var in place
  # data.table format is faster than tidyverse
  data[, n_cpt_admission := .N, by = .(member_id, dt_profsvc_start, dt_profsvc_end)]

  return(data)
}

#' remove multiple procedures in one admission cases
#'
#' @param data medicare data
#'
#' @return
#' @export
#'

remove_multi_proc <- function(data) {
  
  if("n_cpt_admission" %in% names(data)){
    data[n_cpt_admission == 1]
  } else {
    data = add_n_proc_admission(data) 
    
    data[n_cpt_admission == 1]
  }
  
}
