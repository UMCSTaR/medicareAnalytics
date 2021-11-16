#' add_n_proc_admission
#' @description Add new variable "n_cpt_admission" to indicate number of CPTs in one hospital admission
#'     using member_id, facility claim admission and discharge dates
#'
#' @param data medicare data
#'
#' @return
#' @export
#' @import data.table
#'
#' @examples
add_n_proc_admission <- function(data) {

  # check and set data.table
  if (is.data.table(data)) {
    setDT(data)
  }

  # add new var in place
  # data.table format is faster than tidyverse
  data[, n_cpt_admission := .N, by = .(member_id, dt_facclm_adm, dt_facclm_dschg)]

  return(data)
}
