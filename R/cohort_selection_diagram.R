#' Cohort selection diagram for defined filters
#' @description This is often used to understand how many cases and surgeons are removed in each filter
#'
#' @param data top data (raw data)
#' @inheritParams  remove_non_complete
#' @param ... 
#'
#' @return
#' @export
#'

cohort_selection_diagram <- function(data,
                                     add_variables = model_vars,
                                     ...) {
  
  # data
  # this <<- is so bizarre!!!
  # if use = or <- , we get an error of not finding the input top_data
  # see https://stackoverflow.com/questions/66360382/error-passing-an-argument-from-a-function-to-grviz-in-diagrammer-object-not-fo
  top_data <<-  paste0("Raw Medicare", n_case_surg(data))
  
  # remove multi procedures
  remove_multi_proc =  medicareAnalytics::remove_multi_proc(data)
  multi_proc = data.table::fsetdiff(data, remove_multi_proc, all = T)
  
  ex1 = paste0("- Multiple procedures in one hospital admission", n_case_surg(multi_proc))
  
  # non-us 
  remove_nonUS_trained  <-   medicareAnalytics::remove_nonUS_trained(remove_multi_proc)
  nonUS_trained = data.table::fsetdiff(remove_multi_proc, remove_nonUS_trained, all = TRUE)
  
  ex2 = paste0("- Non-US Medschool graduates", n_case_surg(nonUS_trained))
  
  # fellowship
  remove_fellowship =  medicareAnalytics::remove_fellowship(remove_nonUS_trained)
  fellowship = data.table::fsetdiff(remove_nonUS_trained, remove_fellowship, all = TRUE)
  
  ex3 = paste0("- Fellowship trained (ABS, fellowship council, medicare \nclaim specialty code only as general surgery surgeons)", 
               n_case_surg(fellowship))
  
  # non compelete
  remove_non_complete =  medicareAnalytics::remove_non_complete(remove_fellowship)
  non_complete = data.table::fsetdiff(remove_fellowship, remove_non_complete, all = TRUE)
  
  ex4 = paste0("- Missing information ", 
               n_case_surg(non_complete))
  
  
  exclusions_all <<-  paste('Exclusions:', ex1, ex2, ex3, ex4, sep = "\n")
  
  # end data
  end_data <<-  paste0("Analysis Cohort", n_case_surg(remove_non_complete))
  
  
  # diagram
  DiagrammeR::grViz(
    "digraph flowchart {
  
  # node definitions with substituted label text
  node [fontname = Helvetica, shape = rectangle, fixedsize = false, width = 1]
  
  
  1 [label = '@@1']
  2 [label = '@@2']
  m1 [label = '@@3']

  node [shape=none, width=0, height=0, label='']
  p1 -> 2;
  {rank=same; p1 -> m1}

  edge [dir=none]
  1 -> p1;
  }
  [1]: top_data
  [2]: end_data
  [3]: exclusions_all
")
  
}

#' Number of cases and surgeons in the dataset
#' @details surgeon variable name shoule be id_physician_npi
#' @param data 
#'
#' @return
#' @export

n_case_surg <- function(data) {
  paste0("\ncases (n = ",
         scales::comma(nrow(data)), "), ", "surgeons (n = ",
         scales::comma(dplyr::n_distinct(data$id_physician_npi)), ")")
}



