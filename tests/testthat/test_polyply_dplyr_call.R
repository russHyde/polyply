###############################################################################

context("tests for dplyr-verb function builder")

###############################################################################

test_that("build_method_from_dplyr_verb", {
  # Build a function to manipulate a single dataframe in a polyframe

  df1 <- data.frame(a = 1:3, b = letters[1:3])
  df2 <- data.frame(d = 4:6)
  pf1 <- poly_frame(df1 = df1, df2 = df2)

  my_arrange <- build_method_from_dplyr_verb(dplyr::arrange)

  expect_equal(
    object = my_arrange(pf1, dplyr::desc(b)),
    expected = poly_frame(
      df1 = dplyr::arrange(df1, dplyr::desc(b)),
      df2 = df2
    ),
    info = "build a dplyr arrange verb for a poly_frame"
  )
})
