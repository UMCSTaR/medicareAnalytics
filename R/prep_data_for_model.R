#' Prepare data for analysis with a statistical model
#' @details create binary variables for models, including ses, race, admission status.
#'     Standardized continuous variables for easy converging; rename variables that need to
#'     be used in models.
#'
#' @param data The current data.
#' @param standardize Character string of variables to standardize (mean 0,
#'   stddev 1)
#'   
#'   
#' @return A data frame worthy of applying a statistical model to.
#'
#' @examples
#' @export
prep_data_for_model <- function(
  data, 
  standardize = c('age_at_admit',
                  'AHRQ_score',
                  'val_hosp_rn2bed_ratio',
                  'val_hosp_mcday2inptday_ratio',
                  'val_hosp_rn2inptday_ratio')
) {
  
  # standardize numeric -----------------------------------------------------
  
  if (!is.null(standardize)) {
    data = data %>% 
      mutate_at(standardize, function(x) scale(x)[,1]) %>% 
      rename_at(standardize, function(x) paste0(x, '_std'))
  }
  
  # categorical to binary ------------------------------------------------------
  
  # race; wbho = 1234
  data = data %>%
    mutate(race_white = ifelse(e_race_wbho == 1, 1, 0))
  
  # e_admit_type 1- emergency 2 urgent 3 elective 4 other 9 UK/missing
  data = data %>%
    mutate(emergency_status = ifelse(e_admit_type == "1_Emergency" | e_admit_type == "2_Urgent", "emergent", "elective"))
  
  # ses 5 groups
  data = data %>%
    mutate(ses = ifelse(e_ses_5grp<=2, "bottom2quintiles", "top3quintiles"))
  
  # facility claim year starting from 0
  data = data %>%
    mutate(facility_clm_yr_from_year0 = facility_clm_yr - min(facility_clm_yr))
  
  
  # convert logical to integers ---------------------------------------------
  data = mutate_if(data, is.logical, as.integer)
  
  
  # misc other --------------------------------------------------------------
  
  # for random effects
  data = data %>% 
    mutate(
      id_physician_npi   = factor(id_physician_npi),
      facility_prvnumgrp = factor(facility_prvnumgrp)
    )
  
  # rename variables
  data = data %>%
    mutate(sex = ifelse(flg_male == 1, "male", "female"),
           hospital_beds_gt_350 = ifelse( e_hosp_beds_4grp %in% c(3,4), 1, 0)) %>% 
    rename(
      id_surgeon = id_physician_npi,
      id_hospital = facility_prvnumgrp,
      procedure = e_proc_grp_lbl,
      year = facility_clm_yr_from_year0,
      surgeon_years_experience = val_yr_practice,
      hospital_urban = flg_hosp_urban_cbsa,
      hospital_icu = flg_hosp_ICU_hosp,
      hospital_rn2bed_ratio_std = val_hosp_rn2bed_ratio_std,
      hospital_mcday2inptday_ratio_std = val_hosp_mcday2inptday_ratio_std,
      hospital_rn2inptday_ratio_std = val_hosp_rn2inptday_ratio_std,
      death_30d = flg_death_30d,
      severe_complication = flg_cmp_po_severe_not_poa,
      readmission_30d = flg_readmit_30d,
      reoperation_30d = flg_util_reop
    ) 
  
  # convert char to factor just to avoid potential issues with bam
  
  data = data %>% 
    mutate_if(is.character, as.factor)
  
  
  # return ------------------------------------------------------------------
  
  as_tibble(data)
  
}
