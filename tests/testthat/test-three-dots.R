test_that("glanceThreeDots() generates expected HTML", {
  expect_snapshot(glanceThreeDots())
})

test_that("threeDots() generates the correct HTML", {
  expect_snapshot(threeDots(plotOutput("plot")))
})
