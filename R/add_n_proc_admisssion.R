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
    data.table::setDT(data)
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


#' Remove multiple ECV procedures and keep one unique ECV case
#'
#' @param data  medicare data
#'
#' @return
#' @export
#'

remove_multi_ecv_proc <- function(data) {
  model_vars = c(
    "flg_cmp_po_severe",
    # outcome
    "val_yr_practice",
    # primary variable
    "flg_male",
    "age_at_admit",
    "e_race_wbho",
    "e_admit_type",
    "AHRQ_score",
    "e_ses_5grp",
    "facility_clm_yr",
    "had_assist_surg",
    "id_physician_npi",
    "facility_prvnumgrp",
    "e_proc_grp_lbl"
  )
  
  # remove multiple procedures using ECS
  data[, n_ecs_proc_admission := uniqueN(e_proc_grp_lbl), by = .(member_id, dt_profsvc_start, dt_profsvc_end)]
  
  medicare_unique = data %>%
    filter(n_ecs_proc_admission ==1)  %>%
    distinct(!!!syms(model_vars),.keep_all = TRUE)
  
}


