# test that episode works correctly

context("epsiode()")

test_that("Episode throws errors",{

  # fail when not a valid series
  expect_error(epsiode("foo"))
  # fail when season doesn't exist
  expect_error(epsiode("TOS", 17))

})
