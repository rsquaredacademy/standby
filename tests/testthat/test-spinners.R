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
