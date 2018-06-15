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
- [] `activate.poly_frame` method for as-variable indexing
- [+] `filter`/`filter_` methods

## Functions

- [+] `as_poly_frame` with bare df-list
- [+] `as_poly_frame` with merging function
- [] `poly_frame` function with '...'-expanded data-frame set and a
  merging-function

## Documentation

- [] Style-guide
    - Classes are S3
    - Use tidyverse style-guide
    - Use styler and lintr

## Example data

- []

## Git structure

- [] Add `develop` branch
- [] Add initial tag to `master`

## Continuous Integration

- [] Add Travis file

- [] Ensure lintr tests in `test_package_style.R` fail in Travis-CI when an
  inappropriately formatted file is present

----
