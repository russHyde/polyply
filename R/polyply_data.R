#' Brain / Body sizes of several mammalian and dinosaur species
#'
#' @format   Blah blah blah
#'
#' @source   the MASS package
"animals"

#' Mappings from common-name to genus-species or genus-species-subspecies
#' for animals in the `animals` dataset
#'
#' @format   Blah blah blah
#'
#' @source   Random web-searching
"common_to_species"

#' Mappings from species-name to taxonomic 'family' and 'order' for a subset of
#' the animals present in the `animals` dataset
#'
#' Note that only mammalian species returned any family / order annotations, so
#' you'll have to live without dinosaurs for now.
#'
#' @format   23 * 3 data.frame; columns 'species', 'family', 'order'
#'
#' @source   Used taxize::classification over the NCBI database and the species
#'    names present in `common_to_species`. Code is given in
#'    `origins_of_the_datasets.Rmd`.
"taxonomy"
