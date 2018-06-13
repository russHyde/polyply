###############################################################################

# Data validity functions for `polyply` package

###############################################################################

#' @importFrom   methods       is
#'
.is_nonempty_list_of_data_frames <- function(x){
  !missing(x) &&
    length(x) &&
    methods::is(x, "list") &&
    all(purrr::map_lgl(x, methods::is, "data.frame"))
}

###############################################################################
