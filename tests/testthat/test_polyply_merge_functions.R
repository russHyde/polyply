###############################################################################

context("Tests for merging functions in `polyply`")

###############################################################################

test_that(".default_merge_fn", {
  # 'Merge function's should be written to work on a list of data-frames

  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(b = 2:4)
  df3 <- data.frame(a = 1:2, c = 3:4)

  expect_equal(
    .default_merge_fn(list(df1)),
    df1,
    info = "merging a list with a single data-frame => that data-frame"
  )

  expect_equal(
    .default_merge_fn(list(df1, df2)),
    merge(df1, df2),
    info = paste(
      "merging a list of two data-frames => same as merging the",
      "two data-frames"
    )
  )

  expect_equal(
    .default_merge_fn(list(df1, df2, df3)),
    merge(merge(df1, df2), df3),
    info = paste(
      "merging a list of three data-frames => left-fold of merging",
      "the three data-frames"
    )
  )
})

###############################################################################
