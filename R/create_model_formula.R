#' Create model formulas
#'
#' @param targets character vector of target variable names 
#' @param primary_covariate character string of the key predictor variable
#' @param other_covariates character vector of other predictors
#' @param random_effects names of the random effect variables. Default is id_surgeon.
#' @param interaction_term a character vector
#' @param mgcv logical. Convert random effects specification to mgcv style? Default is false.
#'
#' @return a list of model formulas
#' @export
#'
#' @examples 
#' create_model_formulas(
#' targets = c("severe_complication", "death_30d"),
#' primary_covariate = 's(surgeon_years_experience, k = 5)',
#' other_covariates = model_covariates,
#' random_effects = c(
#'   'procedure, surgeon_years_experience',
#'   'id_surgeon',
#'   'id_hospital',
#'   'cpt_cd'),
#' mgcv = F) # a glmm model for lme4

create_model_formulas <- function(
  targets = outcomes,
  primary_covariate = primary,
  other_covariates = covariates,
  random_effects = 'id_surgeon',
  interaction_term = NULL,
  mgcv = FALSE
) {
  
  # interaction
  covariates_all = paste0(
    primary_covariate, 
    ifelse(!is.null(interaction_term),' * ', ''), 
    ifelse(!is.null(interaction_term), interaction_term, ''), 
    ' + ',
    paste0(other_covariates, collapse = ' + ')
  )
  
  if (mgcv)
    re = paste0(' + s(', random_effects, ", bs = 're')", collapse = '')
  # " + s(id_physician_npi, bs='re') + s(facility_prvnumgrp, bs = 're')"
  else 
    re = paste0(' + (1 | ', random_effects, ')', collapse = '')
  
  lapply(targets, function(y) paste0(paste0(y, ' ~ '), covariates_all, re))
}