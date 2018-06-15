###############################################################################

context("Tests for `filter` on a poly_frame")

###############################################################################

test_that("filter without merge", {
  # filtering algebra:
  # (df_1, ..., df_j, ..., df_k) --> pf --> activate(j) --> filter(f)
  # [: equal_to :]
  # (df_1, ..., filter(df_j, f), ..., df_k) --> pf --> activate(j)

  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(b = 2:4)
  pf1 <- as_poly_frame(list(df1 = df1))
  pf2 <- as_poly_frame(list(df1 = df1, df2 = df2))

  expect_equal(
    filter(pf1, a >= 1),
    pf1,
    info = paste(
      "trivial filter on the active data-frame: should not change the",
      "poly_frame"
    )
  )

  expect_equal(
    filter(pf1, a >= 2),
    as_poly_frame(list(df1 = filter(df1, a >= 2))),
    info = paste(
      "filtering on the active data-frame should return a poly_frame",
      "the same as if the data-frame had been filtered prior to poly_frame",
      "construction"
    )
  )

  expect_equal(
    object = list(
      df1 = df1, df2 = df2
    ) %>%
      as_poly_frame() %>%
      activate(2) %>%
      filter(b <= 3),
    expected = list(
      df1 = df1, df2 = filter(df2, b <= 3)
    ) %>%
      as_poly_frame() %>%
      activate(2),
    info = "filtering on a non-default data-frame"
  )
})
