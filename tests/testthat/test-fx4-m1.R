test_that("fx4 M1: loader styles use only known attribute names", {
  invalid <- list("x onmouseover=alert(1) y", "bogus", c("half", "inverse"),
                  NA, character(), TRUE, 1)
  for (style in invalid) {
    expect_error(loaders(shiny::div(), style = style),
                 "`style` must be one of: half, inverse, rounded, blink, NULL", fixed = TRUE)
    expect_error(loaders(shiny::div(), style = style, text = "Loading"),
                 "`style` must be one of:", fixed = TRUE)
  }
  for (style in c("half", "inverse", "rounded", "blink")) {
    type <- if (style == "rounded") "bar" else "default"
    loader <- loaders(shiny::div(), type = type, style = style)$children[[1]]
    expected <- c("id", "class", if (style == "blink") c("data-text", "data-blink") else paste0("data-", style))
    expect_identical(names(loader$attribs), expected)
  }
  expect_true(grepl("data-half", as.character(loaders(shiny::div(), style = "half", text = "Loading"))))
})
