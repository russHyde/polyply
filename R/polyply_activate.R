###############################################################################

# Allow user to select which data-frame is `in play` for subsequent calls to
# dplyr verbs
# - See `tidygraph` code by Thomas Lin Pedersen since a lot of the code here is
# either copied or inspired by that package

###############################################################################

# Ensure tidygraph::activate is visible

#' @importFrom   tidygraph     activate
#' @export
#'
tidygraph::activate

###############################################################################

#' Activate a data-frame within a poly_frame
#'
#' @param        .data         A poly_frame.
#' @param        what          An index for that data-frame within the
#'   poly_frame which is to be activated (i.e. become the data-frame that is
#'   prepared for filtering / selecting). This may be specified by an integer
#'   index or by variable-name (i.e. \code{activate(pf, some_df_name)}).
#'
#' @importFrom   rlang         enquo   quo_text   quo_is_symbol
#'
#' @export
#'
activate.poly_frame <- function(.data, what) {
  # At present I'm struggling to define this method in such a way that
  # - integer indexing : activate(pf, 2)
  # - entry-name indexing : activate(pf, "some_data_frame")
  # - by-variable indexing : activate(pf, some_data_frame)
  # can all be done
  #
  # At present the user should be able to use both by-variable-name and
  # by-integer indexing
  #
  # And I could define '_'-suffixed functions to mimic the entry-name indexing
  # used in select_, filter_ etc
  #

  eqw <- rlang::enquo(what)

  w <- if (rlang::quo_is_symbol(eqw)) {
    rlang::quo_text(eqw)
  } else {
    what
  }

  stopifnot(length(w) == 1)
  stopifnot(
    w %in% names(.data) || w %in% seq(length(.data))
  )
  active(.data) <- w

  .data
}

###############################################################################

#' Return the index of the currently-active data-frame in a poly_frame
#'
#' @param        x             An object which has a 'active' attribute.
#'

active <- function(x) {
  UseMethod("active")
}

#' Return the index of the currently-active data-frame in a poly_frame
#'
#' @param        x             A poly_frame.

active.poly_frame <- function(x) {
  attr(x, "active")
}

#' Return the contents of the currently-active data-frame from the poly_frame
#'
#' @param        x             A poly_frame.

extract_active_df <- function(x) {
  x[[active(x)]]
}

###############################################################################

#' Define which of the data-frames in a poly_frame is the `currently-active`
#' data-frame
#'
#' @param        x             A poly_frame.
#' @param        value         The index of an entry in the poly_frame. This
#'   will become the active data-frame. [Currently: data-frames can be indexed
#'   by integers only].
#'

`active<-` <- function(x, value) {
  UseMethod("active<-")
}

`active<-.poly_frame` <- function(x, value) {
  attr(x, "active") <- value
  x
}

#' Change the contents of the currently-active data-frame in the poly_frame
#'
#' This may alter your ability to merge the data-frames correctly
#'
#' @param        x             A poly_frame
#' @param        .df           A data-frame to be stored in the active-slot of
#'   the poly_frame \code{x}
#'

update_active_df <- function(x, .df) {
  stopifnot(is.data.frame(.df))
  x[[active(x)]] <- .df
  x
}

###############################################################################
