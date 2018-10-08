###############################################################################

# dplyr verbs

###############################################################################

#' @include      polyply_dplyr_call.R
#'
#' @importFrom   dplyr         filter
#' @export
#'
dplyr::filter

#' @importFrom   dplyr         mutate
#' @export
#'
dplyr::mutate

#' @importFrom   dplyr         select
#' @export

dplyr::select

###############################################################################

#' Filter the active data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Filtering predicates, as would be used in
#'   dplyr::filter.
#'
#' @export

filter.poly_frame <- build_method_from_dplyr_verb(dplyr::filter)

#' Mutate the active data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Mutation predicates, as would be used in
#'   dplyr::mutate.
#'
#' @export

mutate.poly_frame <- build_method_from_dplyr_verb(dplyr::mutate)

#' Select within the active data-frame of a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Columns for selection, as would be used in
#'   dplyr::select.
#'
#' @export

select.poly_frame <- build_method_from_dplyr_verb(dplyr::select)
