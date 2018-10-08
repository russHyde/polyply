###############################################################################

# dplyr verbs

###############################################################################

#' @include      polyply_dplyr_call.R
#'
#' @importFrom   dplyr         filter
#' @export
#'
dplyr::filter

#' @importFrom   dplyr         group_by
#' @export
#'
dplyr::group_by

#' @importFrom   dplyr         mutate
#' @export
#'
dplyr::mutate

#' @importFrom   dplyr         rename
#' @export
dplyr::rename

#' @importFrom   dplyr         select
#' @export

dplyr::select

#' @importFrom   dplyr         ungroup
#' @export

dplyr::ungroup

###############################################################################

#' Filter the active data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Filtering predicates, as would be used in
#'   dplyr::filter.
#'
#' @export

filter.poly_frame <- build_method_from_dplyr_verb(dplyr::filter)

#' Group the entries in the active data-frame by a set of columns, within a
#'   poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Grouping predicates, as would be used in
#'   dplyr::group_by, and other args to be passed to dplyr::group_by.
#'
#' @export

group_by.poly_frame <- build_method_from_dplyr_verb(dplyr::group_by)

#' Mutate the active data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Mutation predicates, as would be used in
#'   dplyr::mutate.
#'
#' @export

mutate.poly_frame <- build_method_from_dplyr_verb(dplyr::mutate)

#' Rename columns in the active data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Renaming details, as would be used in
#'   dplyr::rename.
#'
#' @export

rename.poly_frame <- build_method_from_dplyr_verb(dplyr::rename)

#' Select within the active data-frame of a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        ...           Columns for selection, as would be used in
#'   dplyr::select.
#'
#' @export

select.poly_frame <- build_method_from_dplyr_verb(dplyr::select)

#' Ungroup the columns of the active data-frame, within a poly_frame
#'
#' @param        x             A poly_frame.
#' @param        ...           See dplyr::ungroup
#'
#' @export

ungroup.poly_frame <- function(x, ...) {
  .active_df <- extract_active_df(x)
  .df <- dplyr::ungroup(.active_df, ...)
  update_active_df(x, .df)
}
