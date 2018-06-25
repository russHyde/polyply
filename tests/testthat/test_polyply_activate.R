###############################################################################

context("Tests for setting/accessing the currently-active data-frame")

# There's more tests that normal because I've never had to write
# quoting/unquoting arguments before.

###############################################################################

test_that("activate a data-frame", {
  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(b = 2:4)
  df3 <- data.frame(a = 2:3, c = letters[1:2])

  pf1 <- as_poly_frame(list(df1, df2, df3))
  pf2 <- as_poly_frame(list(x1 = df1, x2 = df2, x3 = df3))

  # -- activate a data-frame by numeric index -- #
  expect_error(
    activate(pf1, 0),
    info = "numeric-index is less than that of any contained data-frame"
  )
  expect_error(
    activate(pf1, 4),
    info = "numeric-index is greater than that of any contained data-frame"
  )
  expect_error(
    activate(pf1, 2.5),
    info = "numeric-index should be numerically equal to an integer"
  )

  # -- activate a data-frame by varname -- #
  expect_error(
    activate(pf2, y),
    info = paste(
      "activate(pf2, varname) then varname should be the name of an entry in",
      "the list underlying pf2"
    )
  )

  # -- number of arguments -- #
  expect_error(
    activate(pf2, 2:3),
    info = "can only activate() on a single index"
  )
  expect_error(
    activate(pf2, numeric(0)),
    info = "user must provide an index to activate() on"
  )
})

###############################################################################

test_that("Which data-frame is active?", {
  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(b = 2:4)
  df3 <- data.frame(a = 2:3, c = letters[1:2])

  pf1 <- as_poly_frame(list(df1, df2))
  pf2 <- as_poly_frame(list(df1, df2, df3))
  pf3 <- as_poly_frame(list(a = df1, b = df2))

  expect_equal(
    active(pf1),
    1,
    info = "the first data-frame should be active initially"
  )

  active(pf1) <- 2
  expect_equal(
    active(pf1),
    2,
    info = paste(
      "after activating using active(...)<-X, the X'th data-frame",
      "should be active"
    )
  )

  expect_equal(
    active(activate(pf2, 2)),
    2,
    info = paste(
      "after activating using activate(x, y), the y'th data-frame",
      "should be active [1]"
    )
  )

  expect_equal(
    active(activate(pf2, 3)),
    3,
    info = paste(
      "after activating using activate(x, y), the y'th data-frame",
      "should be active [2]"
    )
  )

  expect_equal(
    active(activate(pf3, b)),
    "b",
    info = paste(
      "after activating it using activate(pf3, b), the 'b' data-frame should",
      "be active"
    )
  )

  x <- 4
  expect_equal(
    active(activate(pf2, sqrt(x))),
    2,
    info = "activate() should work ok with symbolic evaluation to an integer"
  )

  a <- 2
  expect_equal(
    active(activate(pf3, a)),
    "a",
    info = paste(
      "If a variable 'a' is defined in scope and is also the name of an entry",
      "in the poly_frame, after activating using activate(pf, a) it should",
      "activate the 'a' data-frame in the poly-frame, regardless of the value",
      "stored in 'a'"
    )
  )
})

###############################################################################

test_that("get the active dataframe", {
  df1 <- data.frame(1:3)
  df2 <- data.frame(2:4)
  pf1 <- as_poly_frame(list(df1 = df1, df2 = df2))

  expect_equal(
    extract_active_df(pf1),
    df1,
    info = "by default, the active data-frame is the first in the poly_frame"
  )

  expect_equal(
    extract_active_df(activate(pf1, 2)),
    df2,
    info = paste(
      "after activating a data-frame, that should be the",
      "data-frame that's returned by get_active_df"
    )
  )
})

test_that("set the contents of the active dataframe", {
  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(b = 2:4)
  df3 <- data.frame(a = 1:2, b = 2:3)
  pf1 <- as_poly_frame(list(x = df1, y = df2))
  pf2 <- as_poly_frame(list(x = df3, y = df2))
  pf3 <- as_poly_frame(list(x = df1, y = df3))

  expect_equal(
    update_active_df(pf1, df1),
    pf1,
    info = "replace the active data-frame with an identical copy: no change"
  )

  expect_equal(
    update_active_df(pf1, df3),
    pf2,
    info = "replace the default-active-data-frame"
  )

  expect_equal(
    update_active_df(activate(pf1, 2), df3),
    activate(pf3, 2),
    info = "replace a non-default active-data-frame"
  )

  expect_error(
    update_active_df(pf1, "Not-a-data-frame"),
    info = "you can replace the active data-frame with another data-frame "
  )
})

###############################################################################
