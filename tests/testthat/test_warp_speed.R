context("warp_speed()")

test_that("Warp factor > 10 throws error in TNG and later", {
  expect_error(warp_speed(11, originalseries = FALSE))
})

test_that("Warp factor 1 == speed of light", {
  expect_equal(warp_speed(1, originalseries = TRUE), 299792458)
  expect_equal(warp_speed(1, originalseries = FALSE), 299792458)
})

test_that("Warp factor 10 == infinity in TNG and later", {
  expect_equal(warp_speed(10, originalseries = FALSE), Inf)
})