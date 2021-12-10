#' ggplot theme used for publication
#' @description changing label fonts
#'
#' @return
#' @export
#'
theme_cstar <- function() {
  theme_classic() +
    theme(
      axis.title.y        = element_text(angle = 90, size = 14),
      axis.text.y         = element_text(size = 13),
      strip.background    = element_blank(),
      strip.text.y = element_text(size = 10, angle = 0),
      axis.text.x         = element_text(size = 13),
      axis.title.x        = element_text(size = 16),
      axis.ticks.length.x = unit(3, "points"),
      plot.title          = element_text(hjust = 0.5, size = 16)
    )
}