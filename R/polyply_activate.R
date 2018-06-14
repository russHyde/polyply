###############################################################################

# Allow user to select which data-frame is `in play` for subsequent calls to
# dplyr verbs
# - See `tidygraph` code by Thomas Lin Pedersen since a lot of the code here is
# either copied or inspired by that package

###############################################################################

#' NULL function to ensure tidygraph::activate is visible
#'
#' @importFrom   tidygraph        active   activate
activate <- tidygraph::activate

###############################################################################

#' @importFrom   rlang         enquo   quo_text
activate.poly_frame <- function(.data, what) {
  # At present I'm struggling to define this method in such a way that
  # - integer indexing : activate(pf, 2)
  # - entry-name indexing : activate(pf, "some_data_frame")
  # - by-variable indexing : activate(pf, some_data_frame)
  # can all be done
  #
  # TODO: Read Metaprogramming section of Advanced R (v2)
  # -

  #eqw <- rlang::enquo(what)
  #w <- rlang::quo_text(eqw)

  #print(eqw)
  #print(w)

  active(.data) <- if (is.numeric(what)) {
    stopifnot(what %in% (1:length(.data)))
    what
  }
  #else {
  #  rlang::quo_text(rlang::enquo(what))
  #}
  .data
}

###############################################################################

active <- function(x) {
  UseMethod("active")
}

active.poly_frame <- function(x) {
  attr(x, "active")
}

###############################################################################

`active<-` <- function(x, value) {
  UseMethod("active<-")
}

`active<-.poly_frame` <- function(x, value) {
  attr(x, "active") <- value
  x
}

###############################################################################
