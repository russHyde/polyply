###############################################################################

context("Tests for data_validity functions")

###############################################################################

test_that(".is_nonempty_list_of_data_frames", {
  expect_false(
    .is_nonempty_list_of_data_frames(),
    "No input"
  )
  expect_false(
    .is_nonempty_list_of_data_frames(list()),
    "Empty list input"
  )
  expect_false(
    .is_nonempty_list_of_data_frames("Not a list"),
    "Non-list input"
  )
  expect_false(
    .is_nonempty_list_of_data_frames(list("Not a data-frame")),
    "List-contents are not data-frames"
  )
  expect_false(
    .is_nonempty_list_of_data_frames(
      data.frame(a = "Data-frames are lists but not lists of data-frames")
    ),
    "Data-frame input"
  )
  expect_true(
    .is_nonempty_list_of_data_frames(
      list(data.frame(a = 1:3))
    ),
    "Valid list of one data-frame"
  )
  expect_false(
    .is_nonempty_list_of_data_frames(
      list(data.frame(a = 1:3), "not a data-frame")
    ),
    "Invalid list: one data-frame, one string"
  )
  expect_true(
    .is_nonempty_list_of_data_frames(
      list(data.frame(a = 1:3), data.frame(b = letters))
    ),
    "Valid list of two data-frames"
  )
  if (requireNamespace("tibble", quietly = TRUE)) {
    expect_true(
      .is_nonempty_list_of_data_frames(
        list(tibble::tibble(a = 1:3))
      ),
      "Valid list of one tibble"
    )
  }
})
