###############################################################################

# Provide purrr verbs for poly_frame objects

###############################################################################

#' @param        .x
#' @param        .f
#' @param        ...
#'
#' @export
map_pf <- function(.x, .f, ...) {
  purrr::map(.x, .f, ...) %>%
    as_poly_frame()
}
