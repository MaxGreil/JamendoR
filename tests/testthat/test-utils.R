test_that("Control limit works", {
  expect_equal(controlLimit(100), 100)
  expect_equal(controlLimit(201), 200)
})
