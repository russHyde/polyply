###############################################################################

context("Tests for `mutate` on a poly_frame")

###############################################################################

# mutation algebra:
#
# pf --> activate(j) --> mutate(f) --> extract_active_df
# [equiv to]
# pf --> activate(j) --> extract_active_df --> mutate(f)

test_that("mutation then extraction", {
  df1 <- data.frame(a = 1:3)
  pf1 <- as_poly_frame(list(df1 = df1))

  expect_equal(
    object = pf1 %>%
      mutate(a2 = a * 2) %>%
      extract_active_df(),
    expected = pf1 %>%
      extract_active_df() %>%
      mutate(a2 = a * 2),
    info = paste(
      "Mutation-then-extraction of the active data-frame should match",
      "extraction-then-mutation of the active data-frame"
    )
  )
})

###############################################################################

test_that("mutation_then_merge", {

})

###############################################################################
