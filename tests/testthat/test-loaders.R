test_that("glanceLoaders() generates the correct HTML", {
  expect_snapshot(glanceLoaders())
})

test_that("loaders generates the correct HTML", {
  expect_snapshot(
    loaders(uiOutput = plotOutput("plot"),
            type = "default",
            style = "half",
            text = "Loading...")
    )
})
