###############################################################################

# `poly_frame` S3 class/method definitions for `polyply` package

###############################################################################

#' Create a poly_frame object
#'
#' @param        x             An R object for conversion into a poly_frame
#' @param        ...           Further arguments that define how to construct /
#'   manipulate the poly_frame.
#'
#' @rdname       as_poly_frame
#' @export
#'
as_poly_frame <- function(x, ...) {
  UseMethod("as_poly_frame")
}

###############################################################################

#' Create a poly_frame object from a list of data-frames
#'
#' @param        x             A non-empty list of data-frames
#' @param        merge_fn      A function that defines how the data-frames are
#'   to be merged together.
#' @param        ...           Further arguments (unused at present).
#'
#' @include      polyply_data_validity.R
#' @export
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

#' @export
as.list.poly_frame <- function(x, ...) {
  class(x) <- "list"
  attr(x, "merge_fn") <- NULL
  attr(x, "active") <- NULL
  x
}

#' @export
merge.poly_frame <- function(x, ...) {
  get_merge_fn(x)(x)
}

###############################################################################

# accessors & setters

get_merge_fn <- function(x) {
  UseMethod("get_merge_fn")
}

get_merge_fn.poly_frame <- function(x) {
  attr(x, "merge_fn")
}

set_merge_fn <- function(x, merge_fn) {
  UseMethod("set_merge_fn")
}

set_merge_fn.poly_frame <- function(x, merge_fn) {
  attr(x, "merge_fn") <- merge_fn
  x
}

###############################################################################
