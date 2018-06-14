###############################################################################

context("Tests for setting/accessing the currently-active data-frame")

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
    info = paste("after activating using active(...)<-X, the X'th data-frame",
      "should be active"
    )
  )

  expect_equal(
    active(activate(pf2, 2)),
    2,
    info = paste("after activating using activate(x, y), the y'th data-frame",
      "should be active [1]"
    )
  )

  expect_equal(
    active(activate(pf2, 3)),
    3,
    info = paste("after activating using activate(x, y), the y'th data-frame",
      "should be active [2]"
    )
  )

  #expect_equal(
  #  active(activate(pf3, b)),
  #  "b",
  #  info = paste("activation using unquoted list-entry-name")
  #)

  # -- #
  expect_error(
    activate(pf2, 0),
    info = "numeric-index is less than that of any contained data-frame"
  )
  expect_error(
    activate(pf2, 4),
    info = "numeric-index is greater than that of any contained data-frame"
  )
  expect_error(
    activate(pf2, 2.5),
    info = "numeric-index should be numerically equal to an integer"
  )
})

###############################################################################
