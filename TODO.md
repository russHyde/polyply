# TODO notes for `polyply` package

This package is hosted on github, so any issues and bug reports should be
posted there. Here we document those large-scale features that are to be added
to the package.

----

# TODO notes by feature

----

# TODO notes by type

## Tests

- [+] Construction of a `poly_frame`
- [+] `merge_fn` attribute of a `poly_frame`
- [+] Merge a `poly_frame`
- [+] Convert a `poly_frame` back to a list of data-frames
- [+] Slice/extract on a `poly_frame`
- [+] 'active' attribute of a `poly_frame`
- [+] `activate` method
- [+] `filter`ing pass-through after `activate`
- [+] `lintr`-checking test
    - Dev must use `devtools::test()` or `devtools::check(check_dir = ".")` to
      ensure that source-code is available for this test to run
    - No source code is present upon which to lint when using
      `devtools::check()`

## Classes

### `poly_frame`

- [+] construction using `as_poly_frame`
- [+] underlying structure is a list of data-frames
- [+] store a merging function
- [+] `merge.poly_frame` method
- [+] `as.list.poly_frame` method
- [+] `activate.poly_frame` method for numeric indices
- [] `activate.poly_frame` method for by-name indexing
- [+] `activate.poly_frame` method for as-variable indexing
- [+] `filter`/`filter_` methods
- [+] `set_merge_fn` method
- [] `mutate.poly_frame` method

## Functions

- [+] `as_poly_frame` with bare df-list
- [+] `as_poly_frame` with merging function
- [] `poly_frame` function with '...'-expanded data-frame set and a
  merging-function
- [] `as_poly_frame.ExpressionSet` and `as_poly_frame.DGEList`

## Documentation

- [+] Style-guide
- [] Vignette
- [] Memory usage while working with polyply:
    - How big can a vector be in R and does this impose constraints on the size
      of tables we can join in-memory
- [] Add a `CONTRIBUTING.md`

## Example data

- [+] Animals from MASS (suitably reformatted);
    - add a second dataframe mapping common-name to species
    - add a third data-frame mapping species to Family
    - and then Family to Order
    - Plot brain ~ body split by Family

## Git structure

- [] Add `develop` branch
- [] Add initial tag to `master`

## Continuous Integration

- [+] Add Travis file
- [+] Ensure lintr tests in `test_package_style.R` fail in Travis-CI when an
  inappropriately formatted file is present

----
