###############################################################################

context("tests that dplyr verbs work for poly_frame objects")

###############################################################################

.setup_basic_polyframe <- function() {
  df1 <- data.frame(a = 1:3, b = letters[1:3])
  df2 <- data.frame(b = letters[3:6])
  poly_frame(df1 = df1, df2 = df2)
}

test_that("`rename` renames columns in the active dataframe", {
  pf1 <- .setup_basic_polyframe()

  expect_equal(
    object = rename(pf1, c = a),
    expected = poly_frame(
      df1 = dplyr::rename(pf1$df1, c = a),
      df2 = pf1$df2
    ),
    info = "rename a column in the active data-frame"
  )
})

###############################################################################

test_that("`group_by` works on the active dataframe", {
  pf1 <- .setup_basic_polyframe()

  expect_equal(
    object = group_by(pf1, b),
    expected = poly_frame(
      df1 = group_by(pf1$df1, b),
      df2 = pf1$df2
    ),
    info = "`group_by` a column in the active data-frame"
  )
})

test_that("`ungroup` works on the active dataframe", {
  df1 <- dplyr::group_by(
    data.frame(a = 1:3, b = letters[1:3]),
    b
  )
  df2 <- data.frame(b = letters[3:6])
  pf1 <- poly_frame(
    df1 = df1, df2 = df2
  )
  expect_equal(
    object = ungroup(pf1),
    expected = poly_frame(df1 = ungroup(df1), df2 = df2),
    info = "`ungroup` on the active data-frame"
  )
})
