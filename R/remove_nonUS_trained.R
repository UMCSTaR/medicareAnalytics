#' Remove Non-US Trained surgeons
#' @description use medciare variable us_medschool based on ABS and AMA
#'
#' @param data medicare data
#'
#' @return medicare data without non-US trained surgeons
#' @export
#'
#' @examples
remove_nonUS_trained <- function(data) {
  data %>% 
    filter(us_medschool == "USMG")
}
