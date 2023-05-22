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

test_that("loaders generates the correct HTML when style is blink", {
  expect_snapshot(
    loaders(uiOutput = plotOutput("plot"),
            type = "default",
            style = "blink")
  )
})

test_that("loaders generates the correct HTML when style is inverse", {
  expect_snapshot(
    loaders(uiOutput = plotOutput("plot"),
            type = "default",
            style = "inverse")
  )
})

test_that("loaders generates the correct HTML when type is curtain", {
  expect_snapshot(
    loaders(uiOutput = plotOutput("plot"),
            type = "curtain",
            text = "Loading...")
  )
})

test_that("loaders generates the correct HTML when type is smartphone", {
  expect_snapshot(
    loaders(uiOutput = plotOutput("plot"),
            type = "smartphone",
            text = "Loading...")
  )
})
