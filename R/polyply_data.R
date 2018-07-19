#' Brain / Body sizes of several mammalian and dinosaur species
#'
#' Body weight is in _kg_. Brain weight is in _g_.
#'
#' @format   28 * 3 data.frame; columns are 'common_name', 'body', 'brain'.
#'
#' @source   the MASS package dataset `Animals` (but, Dipliodocus -> Diplodocus
#'   typo was fixed).
#'
"animals"

#' Mappings from common-name to genus-species or genus-species-subspecies
#'   for animals in the `animals` dataset
#'
#' @format   28 * 2 tibble; columns are 'common_name', 'species'.
#'
#' @source   Haphazardly searching the web using the common-names from
#'   `animals`.
#'
"common_to_species"

#' Mappings from species-name to taxonomic 'family' and 'order' for a subset of
#'   the animals present in the `animals` dataset
#'
#' Note that only mammalian species returned any family / order annotations, so
#'   you'll have to live without dinosaurs for now.
#'
#' @format   23 * 3 data.frame; columns 'species', 'family', 'order'
#'
#' @source   Used taxize::classification over the NCBI database and the species
#'    names present in `common_to_species`. Code is given in
#'    `origins_of_the_datasets.Rmd`.
"taxonomy"
