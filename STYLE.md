# STYLE-GUIDE

1. All classes are `S3`.
2. Where a function/method name overlaps with a `tidyverse` or `tidygraph`
  function, use the same argument names/order as in the `tidy*` equivalent.
3. Run `styler::style_pkg()` before check-in (default settings); this applies
  most of tidyverse style (indentation etc)
4. Run all unit-tests before check-in; this ensures that `lintr` is ran with
  the package lint-setup (as defined in `.lintr`)
5. Parameter definitions / importFroms etc in Roxygen docs start on the 4th
  (for @param/@importFrom etc), 18th (for param / package name) and 32nd
  character (for everything else) of an "@"-containing line, if possible. If
  the preceding text overruns, there should be three spaces between elements.
6. Functions should start with verbs (is/filter/activate) unless they are
  getters / setters for class attributes / entries or conform to wider usage
  in R syntax (`as_poly_frame`)
  <!--
    Is this true for .default_merge_fn and other functions applied by a
    higher-order function?
    -->
7. lint summary:
    - snake_case (including for class-names)
    - max-line-length: 80
    - max-object-length: 40
    - '<-' over '='
    - no trailing blanks (at end of line, or end of file)
    - etc etc - default linters in lintr, minus those mentioned in .lintr

Note:
    - .lintr file is in ./inst/ and is linked to from ./.lintr
    - this is to ensure that my `lintr` rules are ran when testing on   
    travis-CI
    - if .lintr is stored in polyply's main directory, it doesn't get 
    packaged up and the package fails `test_polyply_package_style.R`
    since I have some objects with names over 30-characters (a default 
    which I have overridden to make it a 40-character limit)

Exceptions:

- Objects, functions and methods are snakecase except for
    - S3-based dot-specification of the relevant class (as_poly_frame.list)
    - Some non-exported functions are dot-prefixed
    - R generics that are dot-separated (as.list) are extended
