#' Remove non-complete cases
#' 
#' @details included variables are the commoly used varaibles in the models. Variables included:
#'    "flg_cmp_po_severe", "flg_male", "age_at_admit", "e_race_wbho", "e_admit_type",
#'    "AHRQ_score", "e_ses_5grp","facility_clm_yr", "had_assist_surg",
#'    "e_hosp_beds_4grp","flg_hosp_ICU_hosp", "val_hosp_mcday2inptday_ratio",
#'    "val_hosp_rn2bed_ratio", "id_physician_npi","facility_prvnumgrp"
#'
#' @param data medicare data
#' @param add_variables add more variables that ware not listed, forb example case
#'    value, years of experience. If need to add multiple variables, use syntax c("va1", "var2")
#'
#' @return
#' @export
#'
#' @examples
remove_non_complete <- function(data,
                                add_variables = "val_yr_practice") {
  # model variables from previous runs
  model_vars = c(
    "flg_cmp_po_severe", 
    "flg_male", 
    "age_at_admit", 
    "e_race_wbho",
    "e_admit_type",
    "AHRQ_score", 
    "e_ses_5grp",
    "facility_clm_yr", 
    "had_assist_surg",
    "e_hosp_beds_4grp",
    "flg_hosp_ICU_hosp", 
    "val_hosp_mcday2inptday_ratio", 
    "val_hosp_rn2bed_ratio", 
    "id_physician_npi", 
    "facility_prvnumgrp"
  )
  
  model_vars = c(model_vars, add_variables)
  
  
  data %>% 
    drop_na(!!model_vars)
  
}
