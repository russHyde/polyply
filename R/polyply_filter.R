###############################################################################

# Filter a given data-frame within a poly_frame a-la dplyr

###############################################################################

#' @importFrom   dplyr         filter
#' @export
#'
dplyr::filter

#' Filter the active data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Filtering predicates, as would be used in
#'   dplyr::filter.
#'
#' @export

filter.poly_frame <- build_method_from_dplyr_verb(dplyr::filter)

###############################################################################
