###############################################################################

# Mutate a given data-frame within a poly_frame

###############################################################################

#' @importFrom   dplyr         mutate
#' @export
#'
dplyr::mutate

#' Mutate the active data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Mutation predicates, as would be used in
#'   dplyr::mutate.
#'
#' @export

mutate.poly_frame <- function(.data, ...) {
  .df <- dplyr::mutate(extract_active_df(.data), ...)
  update_active_df(.data, .df)
}

###############################################################################
