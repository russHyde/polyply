###############################################################################

# `select` within a poly_frame

###############################################################################

#' @importFrom   dplyr         select
#' @export

dplyr::select

###############################################################################

#' Select within the active data-frame of a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Columns for selection, as would be used in
#'   dplyr::select.
#'
#' @export

select.poly_frame <- function(.data, ...) {
  .df <- dplyr::select(extract_active_df(.data), ...)
  update_active_df(.data, .df)
}

###############################################################################
