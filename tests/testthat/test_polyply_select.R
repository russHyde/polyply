###############################################################################

context("Tests for `select` on a poly_frame")

###############################################################################

test_that("select on a poly_frame", {
  df1 <- data.frame(a = 1:3, b = letters[1:3])
  pf1 <- poly_frame(df1 = df1)

  expect_equal(
    object = select(pf1, a, b),
    expected = pf1,
    info = "Selecting all available columns in a single-df poly_frame"
  )

  expect_equal(
    object = select(pf1, a),
    expected = poly_frame(df1 = df1[, "a", drop = FALSE]),
    info = "Selecting the first column in a single-df poly_frame by name"
  )
})
