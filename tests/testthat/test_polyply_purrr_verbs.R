###############################################################################

context("tests availability of purrr verbs for poly_frames")

###############################################################################

test_that("map_pf should provide a map function that returns a poly_frame", {
  df1 <- data.frame(a = 1:3, b = letters[1:3])
  df2 <- data.frame(b = letters[3:6])
  l1 <- list(df1 = df1, df2 = df2)
  pf1 <- as_poly_frame(l1)

  expect_is(
    object = map_pf(pf1, head, 2),
    "poly_frame",
    info = "polyply::map_pf(poly_frame, f, ...) should return a poly_frame"
  )

  expect_equal(
    object = map_pf(pf1, head, 2),
    expected = as_poly_frame(
      purrr::map(l1, head, 2)
    ),
    info = "map_pf(poly_frame, f) should equal poly_frame(map(pf_contents, f))"
  )
})
