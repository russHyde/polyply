###############################################################################

#

###############################################################################

#' Elevates a dplyr-verb from a method on a single data-frame, to a method on
#'   a poly_frame
#'
#' When applied to a poly_frame, the returned function will modify the
#'   `currently-active data-frame` using the dplyr verb. All other data-frames
#'   are unmodified and a poly-frame of the same structure is returned (modulo
#'   any changes to the active data-frame).
#'
#' @param        dplyr_fn      Any dplyr verb that acts on a single data-frame.
#'
build_method_from_dplyr_verb <- function(dplyr_fn) {
  function(.data, ...) {
    .active_df <- extract_active_df(.data)
    .df <- dplyr_fn(.active_df, ...)
    update_active_df(.data, .df)
  }
}

###############################################################################
