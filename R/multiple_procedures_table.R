#' multiple procedures in one admission frequency table
#' @description make frequency table for multiple procedures combinations in one admission.
#'     Using the frequency table to see what procedures happened in one admission
#'     more frequently
#'
#' @param data medicare data 
#' @param project_sepcific_procedure_tax project specific procedure taxonomy
#'
#' @import dplyr
#' @import tidyr
#' 
#' @return frequency table
#' @export


multiple_procedures_table <- function(data,
                                      project_sepcific_procedure_tax = "e_proc_grp_lbl") {
  # prep
  project_sepcific_procedure_tax_enquo <- enquo(project_sepcific_procedure_tax)
  
  if(!"n_cpt_admission" %in% names(data)){
    data = medicareAnalytics::add_n_proc_admission(data)
  }
  
  if(!project_sepcific_procedure_tax %in% names(data)){
    stop("taxonomy varaible:", project_sepcific_procedure_tax,
         " is not in your dataset")
  }
  
  
  # filter to multiple procedure cases
  multiple_proc_cases = data[n_cpt_admission >1,]
  
  # add unique key for procedure
  multi_proc_cases_id = multiple_proc_cases %>% 
    distinct(member_id,
             dt_facclm_adm,
             dt_facclm_dschg) %>% 
    mutate(inpatient_case_id = row_number()) 
  
  # get procedure combo
  procedure_combo = multiple_proc_cases %>% 
    left_join(multi_proc_cases_id, by = c("member_id", "dt_facclm_adm", "dt_facclm_dschg")) %>% 
    group_by(inpatient_case_id) %>% 
    arrange(!!project_sepcific_procedure_tax_enquo) %>% 
    mutate(n_case_cnt = row_number()) %>% 
    select(member_id, inpatient_case_id, n_case_cnt, !!project_sepcific_procedure_tax_enquo) %>% 
    tidyr::pivot_wider( names_from = n_case_cnt,
                        names_glue = "proc_{n_case_cnt}",
                        values_from = !!project_sepcific_procedure_tax_enquo) %>% 
    ungroup()
  
  # procedure combination 
  procedure_combo_n = procedure_combo %>% 
    tidyr::unite("proc_combo", starts_with("proc_"), na.rm = T, sep = ", ") %>% 
    count(proc_combo, name = "n_hosp_admission", sort = T)
  
  return(procedure_combo_n)
  
}
