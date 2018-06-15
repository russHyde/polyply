###############################################################################

# Filter a given data-frame within a poly_frame a-la dplyr

###############################################################################

#' @importFrom   dplyr         filter
#'
#' @export

filter.poly_frame <- function(.data, ...) {
  .df <- dplyr::filter(extract_active_df(.data), ...)
  new_poly_frame <- update_active_df(.data, .df)
  new_poly_frame
}

#' @importFrom   dplyr         filter
#' @export

dplyr::filter
