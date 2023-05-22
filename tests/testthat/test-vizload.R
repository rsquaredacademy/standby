test_that("glanceVizLoad generates the correct HTML", {
  expect_snapshot(glanceVizLoad())
})

test_that("viz_bars() generates the correct HTML", {
  expect_snapshot(viz_bars())
})

test_that("viz_squares() generates the correct HTML", {
  expect_snapshot(viz_squares())
})

test_that("viz_circles() generates the correct HTML", {
  expect_snapshot(viz_circles())
})

test_that("viz_dots() generates the correct HTML", {
  expect_snapshot(viz_dots())
})

test_that("viz_spinner() generates the correct HTML", {
  expect_snapshot(viz_spinner())
})

test_that("viz_dashed() generates the correct HTML", {
  expect_snapshot(viz_dashed())
})

test_that("viz_line() generates the correct HTML", {
  expect_snapshot(viz_line())
})

test_that("viz_bordered_line() generates the correct HTML", {
  expect_snapshot(viz_bordered_line())
})

test_that("vizLoad() generates the correct HTML", {
  expect_snapshot(
    vizLoad(uiOutput = plotOutput("plot"),
            type = "bars",
            size = "large",
            color = "red",
            add_label = FALSE,
            label = "Loading...")
  )
})




