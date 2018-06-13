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

  expect_equal(
    as_poly_frame(list(df1))[1],
    list(df1),
    info = paste(
      "poly_frame should be equal to the input list of data-frames",
      "from which it was made (modulo attributes)")
  )
})

###############################################################################
