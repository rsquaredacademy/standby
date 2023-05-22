test_that("glanceSpinners() generates the correct HTML", {
  expect_snapshot(glanceSpinners())
})

test_that("spinners() generates the correct HTML", {
  expect_snapshot(
    spinners(uiOutput = plotOutput("plot"),
             type = 1,
             color = "#0275d8")
  )
})

test_that("spinners() generates the correct HTML when type is 2", {
  expect_snapshot(
    spinners(uiOutput = plotOutput("plot"),
             type = 2,
             color = "#0275d8")
  )
})

test_that("spinners() generates the correct HTML when type is 3", {
  expect_snapshot(
    spinners(uiOutput = plotOutput("plot"),
             type = 3,
             color = "#0275d8")
  )
})

test_that("spinners() generates the correct HTML when type is 4", {
  expect_snapshot(
    spinners(uiOutput = plotOutput("plot"),
             type = 4,
             color = "#0275d8")
  )
})

test_that("spinners() generates the correct HTML when type is 5", {
  expect_snapshot(
    spinners(uiOutput = plotOutput("plot"),
             type = 5,
             color = "#0275d8")
  )
})

test_that("spinners() generates the correct HTML when type is 8", {
  expect_snapshot(
    spinners(uiOutput = plotOutput("plot"),
             type = 8,
             color = "#0275d8")
  )
})
