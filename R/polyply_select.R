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

select.poly_frame <- build_method_from_dplyr_verb(dplyr::select)

###############################################################################
