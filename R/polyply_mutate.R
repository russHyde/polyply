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

mutate.poly_frame <- build_method_from_dplyr_verb(dplyr::mutate)

###############################################################################
