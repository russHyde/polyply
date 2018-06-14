###############################################################################

context("Tests for poly_frame classes and methods")

###############################################################################

test_that("poly_frame construction: invalid input", {
  expect_error(
    as_poly_frame("Not a list"),
    info = "can't make a poly_frame from a string"
  )

  expect_error(
    as_poly_frame(list("not-a-data-frame")),
    info = "can't make a poly_frame from a list of strings"
  )

  expect_error(
    as_poly_frame(list()),
    info = "can't make a poly_frame if theres no entries in the input list"
  )
})

###############################################################################

test_that("poly_frame construction: valid input", {
  df1 <- data.frame(a = 1:3)

  expect_is(
    as_poly_frame(list(df1)), "poly_frame", info = "expect a poly_frame"
  )

  pf1 <- as_poly_frame(list(df1))

  expect_is(
    pf1, "list", info = "poly_frame is a list"
  )

  expect_equal(
    pf1[1],
    list(df1),
    info = paste(
      "A `poly_frame` should be equal to the input list of data-frames",
      "from which it was made (modulo attributes)"
    )
  )

  expect_true(
    "merge_fn" %in% names(attributes(pf1)),
    info = paste(
      "A `poly_frame` should have a merge-function defined in their attributes"
    )
  )

  expect_true(
    "active" %in% names(attributes(pf1)),
    info = paste(
      "A `poly_frame` should have indicate an 'active' data-frame in it's",
      "attributes"
    )
  )
})

###############################################################################

test_that("poly_frame methods: type-conversion and subsetting", {
  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(d = letters)

  pf <- as_poly_frame(list(df1, df2))

  expect_equal(
    as.list(pf),
    list(df1, df2),
    info = "as.list should return the list-of-data-frames in a poly_frame"
  )

  expect_equal(
    pf[1],
    list(df1),
    info = "`[` should return a list"
  )

  expect_equal(
    pf[[1]],
    df1,
    info = "`[[` should return a selected data-frame"
  )

  if (requireNamespace("magrittr", quietly = TRUE)) {
    expect_equal(
      magrittr::extract2(pf, 2),
      df2,
      info = "magrittr::extract2 should work on a poly_frame"
    )

    expect_equal(
      magrittr::extract(pf, 1:2),
      list(df1, df2),
      info = "magrittr::extract should work on a poly_frame"
    )
  }
})

###############################################################################

test_that("poly_frame methods: merge-function accessor / runner", {
  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(b = 2:4)
  .mf_helper <- function(x, y) {
    merge(x, y, by.x = "a", by.y = "b")
  }
  mf <- function(x) {
    .mf_helper(x[[1]], x[[2]])
  }
  pf1 <- as_poly_frame(list(df1, df2))
  pf2 <- as_poly_frame(list(df1, df2), mf)

  expect_true(
    is.function(get_merge_fn(pf1)),
    info = "merge-function within a poly_frame is a function"
  )

  expect_identical(
    get_merge_fn(pf1),
    .default_merge_fn,
    info = "merge-function extracted from a default poly_frame matches",
    "the default merger defined in polyply"
  )

  expect_identical(
    get_merge_fn(pf2),
    mf,
    info = "merge-function extracted from a poly_frame matches the input"
  )

  expect_equal(
    merge(pf1),
    merge(df1, df2),
    info = paste(
      "merge on a poly_frame with two data-frames should return",
      "the same as merging the two individual data-frames"
    )
  )

  expect_equal(
    merge(pf2),
    .mf_helper(df1, df2),
    info = paste(
      "merge a poly_frame with two data-frames using a",
      "non-standard merging function"
    )
  )
})

###############################################################################
