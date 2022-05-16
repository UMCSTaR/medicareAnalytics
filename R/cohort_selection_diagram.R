#' Cohort Selection Diagram
#' @description create cohort selection diagram based on apply_all_filters function. 
#'     This is often used to understand how many cases and surgeons are removed in each filter
#'
#' @param data  original data
#' @inheritParams apply_all_filters 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
cohort_selection_diagram <- function(data,
                                     variables = model_vars,
                                     yoe_cutoff = 35,
                                     ...) {
  
  # data
  # this <<- is so bizarre!!!
  # if use = or <- , we get an error of not finding the input top_data
  # see https://stackoverflow.com/questions/66360382/error-passing-an-argument-from-a-function-to-grviz-in-diagrammer-object-not-fo
  top_data <<-  paste0("Raw Medicare", n_case(data))
  
  # remove multi procedures
  remove_multi_proc =  medicareAnalytics::remove_multi_proc(data)
  multi_proc = data.table::fsetdiff(data, remove_multi_proc, all = T)
  
  ex1 = paste0("- Multiple procedures in one hospital admission", n_case(multi_proc))
  
  # non-us 
  remove_nonUS_trained  <-   medicareAnalytics::remove_nonUS_trained(remove_multi_proc)
  nonUS_trained = data.table::fsetdiff(remove_multi_proc, remove_nonUS_trained, all = TRUE)
  
  ex2 = paste0("- Non-US Medschool graduates", n_case(nonUS_trained))
  
  # fellowship
  remove_fellowship =  medicareAnalytics::remove_fellowship(remove_nonUS_trained)
  fellowship = data.table::fsetdiff(remove_nonUS_trained, remove_fellowship, all = TRUE)
  
  ex3 = paste0("- Fellowship trained (ABS, fellowship council, medicare \nclaim specialty code only as general surgery surgeons)", 
               n_case(fellowship))
  
  # non compelete
  remove_non_complete =  medicareAnalytics::remove_non_complete(remove_fellowship)
  non_complete = data.table::fsetdiff(remove_fellowship, remove_non_complete, all = TRUE)
  
  ex4 = paste0("- Missing information ", 
               n_case(non_complete))
  
  # n years of experience
  remove_le35 =  remove_non_complete %>% filter(val_yr_practice<=yoe_cutoff, val_yr_practice>0)
  remove_gt35 = data.table::fsetdiff(remove_non_complete, remove_le35, all = TRUE)
  
  ex5 = paste0("- More than ", yoe_cutoff, " years of practice ", 
               n_case(remove_gt35))
  
  
  exclusions_all <<-  paste('Exclusions:', ex1, ex2, ex3, ex4, ex5, sep = "\n")
  
  # end data
  end_data <<-  paste0("Analysis Cohort", n_case(remove_le35))
  
  
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

n_case <- function(data) {
  paste0(
    "\ncases (n = ",
    scales::comma(nrow(data)),
    ")"
  )
}


# # filter <1% procedures
# lt_x_perc_proc = remove_le35 %>% 
#   count(score_operation_procedure, sort = T) %>% 
#   mutate(perc = n/sum(n),
#          cum = cumsum(n)/sum(n)) %>% 
#   filter(cum>1-perc_cutoff)
# 
# removed_x_perc_proc = remove_le35 %>% 
#   filter(!score_operation_procedure %in% unique(lt_x_perc_proc$score_operation_procedure))
# 
# ex6 = paste0(
#   "- Remove procedures that had less than ",
#   perc_cutoff * 100,
#   " percent of cases",
#   n_case(remove_le35 %>% filter(
#     score_operation_procedure %in% unique(lt_x_perc_proc$score_operation_procedure)
#   ))
# )
# 
# 
# exclusions_all <<-  paste('Exclusions:', ex1, ex2, ex3, ex4, ex5, ex6, sep = "\n")