###############################################################################

# `poly_frame` S3 class/method definitions for `polyply` package

###############################################################################
#' Create a poly_frame object from a list of data-frames
#'
#' @export
#'
as_poly_frame <- function(x, ...) {
  UseMethod("as_poly_frame")
}

###############################################################################

#' @include      polyply_data_validity.R
#'
as_poly_frame.default <- function(x, ...) {
  # check_validity:
  # - merge_fn is a function
  # - if any names are present, all entries in x should be named
  # - if merge_fn is not defined, set it to reduce-merge
  # pf <- list(
  #  df_list = x,
  #  merge_fn = merge_fn
  # )
  # class(pf) <- "poly_frame"
  # attr(pf, "active") <- 1

  stopifnot(
    .is_nonempty_list_of_data_frames(x)
  )

  structure(x, class = "poly_frame")
}

###############################################################################
