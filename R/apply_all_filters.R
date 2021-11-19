#' Use all cohort filters
#' @details filters including: remove multi procedures, 
#'     remove non-us med school graduates, 
#'     remove fellowship trained surgeons,
#'     remove non-complete cases
#'
#' @param data medicare
#' @param remove_multi_procedure TRUE: remove all mult procedure cases;
#'     FALSE: add variable "n_cpt_admission"
#' @inheritParams remove_fellowship
#' @inheritParams remove_non_complete
#' @param ... parameters inputs for all sub-filter functions: 
#'     remove_multi_proc, addd_n_proc_admission, remove_nonUS_trained, remove_fellowship, remove_non_complete
#'
#' @return
#' @export
#'
#' @examples
apply_all_filters <- function(data, 
                              remove_multi_procedure = T,
                              fellowship_council_data_path,
                              medicare_gs_list_path,
                              add_variables,
                              ...) {
  
  # if remove multi procedures on on admission 
  if(remove_multi_procedure) {
    data = data %>% 
      remove_multi_proc()
  } else {
    data = add_n_proc_admission(data)
  }
  
  data %>% 
    remove_nonUS_trained() %>% 
    remove_fellowship() %>% 
    remove_non_complete()
  
}