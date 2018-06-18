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
#'   poly_frame which is to be activated (ie, become the data-frame that is
#'   prepped for filtering / selecting).
#'
#' @importFrom   rlang         enquo   quo_text
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
  # It should be possible to do both by-variable-indexing and integer-indexing
  # since dplyr does this, eg, in select(my_df, 1:3, some_column)
  #
  # And I could define '_'-suffixed functions to mimic the entry-name indexing
  # used in select_, filter_ etc
  #
  # TODO: Read Metaprogramming section of Advanced R (v2)
  # -

  # eqw <- rlang::enquo(what)
  # w <- rlang::quo_text(eqw)

  # print(eqw)
  # print(w)

  active(.data) <- if (is.numeric(what)) {
    stopifnot(what %in% (1:length(.data)))
    what
  }
  # else {
  #  rlang::quo_text(rlang::enquo(what))
  # }
  .data
}

###############################################################################

#' Return the index of the currently-active data-frame in the poly_frame
#'
#' @param        x             An object which has a 'active' attribute.
#'

active <- function(x) {
  UseMethod("active")
}

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
