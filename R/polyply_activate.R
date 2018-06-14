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

  #eqw <- rlang::enquo(what)
  #w <- rlang::quo_text(eqw)

  #print(eqw)
  #print(w)

  active(.data) <- if (is.numeric(what)) {
    what
  }
  #else {
  #  active(.data) <- rlang::quo_text(rlang::enquo(what))
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
