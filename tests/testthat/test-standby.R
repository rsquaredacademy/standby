test_that("standby dependencies work as expected", {
  sby <- standbyDeps()
  expect_equal(sby$name, "standby")
  expect_equal(sby$version, "0.1.0")
  expect_equal(sby$src$file, "standby")
  expect_equal(sby$stylesheet, "css/standby.css")
  expect_equal(sby$script$src[[1]], "js/standby.js")
})
