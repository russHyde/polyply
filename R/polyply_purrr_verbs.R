###############################################################################

# Provide purrr verbs for poly_frame objects

###############################################################################

#' Map a function over a (named) list and return a `poly_frame` object
#'
#' See `purrr` for details of `map` functions.
#'
#' @param        .x            A list or atomic vector. It should have named
#'   elements otherwise a poly_frame cannot be constructed.
#' @param        .f            A function, formula or atomic vector (as in
#'   input to purrr). The function should return a data-frame when applied to
#'   an input data-frame.
#' @param        ...           Further arguments to the function `.f`
#'
#' @importFrom   magrittr      %>%
#' @export
#'
map_pf <- function(.x, .f, ...) {
  purrr::map(.x, .f, ...) %>%
    as_poly_frame()
}
