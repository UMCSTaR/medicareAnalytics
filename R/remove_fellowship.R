#' Remove Fellowship trained surgeons
#' @description Remove fellowship trained surgeons using ABS, fellowship council and medciare claim specialty code
#'
#' @param data medicare data
#' @param fellowship_council_data_path path to fellowship council dt
#' @param medicare_gs_list_path assign value to NULL if you don't want use the
#'     medicare specialty code criteria.
#'
#' @return medicare dataset that removed fellowship trained surgeons
#' @export
#'

remove_fellowship <- function(data,
                              fellowship_council_data_path = "/Volumes/George_Surgeon_Projects/Surgeon Profile data/fellowship_council/fellowship_npi_manual_linked.csv",
                              medicare_gs_list_path = "/Volumes/George_Surgeon_Projects/Surgeon Profile data/medicare_specialty/all_gs_splty_medicare.rdata") {
  
  fellowship_council_dt = suppressMessages(readr::read_csv(fellowship_council_data_path)) 
  
  data_remove_fc_abs = data %>%
    filter(
      fellowship_abs == FALSE,
      !id_physician_npi %in% fellowship_council_dt$npi
    )
  if (!is.null(medicare_gs_list_path)) {
    load(medicare_gs_list_path)
    
    data_remove_fc_abs %>%
      # has only filed medicare claims as general surgery surgeons
      filter(id_physician_npi %in% gs_splty_only)
  } else {
    return(data_remove_fc_abs)
  }
  
}
