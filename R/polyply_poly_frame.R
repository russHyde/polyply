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
as_poly_frame.list <- function(x, merge_fn, ...) {
  # check_validity:
  # - if any names are present, all entries in x should be named

  if (missing(merge_fn)) {
    merge_fn <- .default_merge_fn
  }

  stopifnot(
    .is_nonempty_list_of_data_frames(x) &&
      is.function(merge_fn)
  )

  structure(
    x,
    class = c("poly_frame", "list"),
    merge_fn = merge_fn,
    active = 1
  )
}

###############################################################################

# standard generics

as.list.poly_frame <- function(x, ...) {
  class(x) <- "list"
  attr(x, "merge_fn") <- NULL
  attr(x, "active") <- NULL
  x
}

merge.poly_frame <- function(x, ...) {
  get_merge_fn(x)(x)
}

###############################################################################

# accessors

get_merge_fn <- function(x) {
  UseMethod("get_merge_fn")
}

get_merge_fn.poly_frame <- function(x) {
  attr(x, "merge_fn")
}

###############################################################################
