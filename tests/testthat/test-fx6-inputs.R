test_that("fx6 H3: only supported loader type/style/text combinations are accepted", {
  supported <- list(half = "default", inverse = c("default", "bar"),
    rounded = c("bar", "bar-ping-pong"), blink = c("default", "bar", "border"))
  text_types <- c("default", "bar", "border", "curtain", "smartphone")
  for (type in fx6_types$loaders) {
    for (style in names(supported)) {
      for (text in list(NULL, "Loading...")) {
        if (!type %in% supported[[style]]) {
          expect_error(loaders(shiny::div(), type, style, text), "`style.*Supported types")
        } else if (!is.null(text) && !type %in% text_types) {
          expect_error(loaders(shiny::div(), type, style, text), "`text`.*Supported types")
        } else {
          node <- loaders(shiny::div(), type, style, text)$children[[1]]
          expect_true(paste0("data-", style) %in% names(node$attribs))
          if (!is.null(text)) expect_identical(node$attribs[["data-text"]], text)
        }
      }
    }
    if (type %in% text_types) {
      expect_no_error(loaders(shiny::div(), type, text = "Loading..."))
    } else {
      expect_error(loaders(shiny::div(), type, text = "Loading..."), "`text`.*Supported types")
    }
  }
  for (text in list(NA, character(), c("a", "b"), TRUE, list("a"))) {
    expect_error(loaders(shiny::div(), text = text), "`text` must be NULL or a single non-missing string", fixed = TRUE)
  }
})

test_that("fx6 M1: invalid vizLoad sizes always name the argument and choices", {
  for (type in fx6_types$vizLoad) {
    choices <- if (type %in% c("line", "bordered_line")) "fluid, large, medium, small" else "large, medium, small, tiny"
    for (size in list(NULL, character(), factor("large"), list("large"), mean,
      NA, c("large", "small"), TRUE, 1, "bogus")) {
      expect_error(vizLoad(shiny::div(), type, size),
        paste0("`size` must be one of: ", choices, "."), fixed = TRUE)
    }
  }
})

test_that("fx6 lows: previews and generated spinner CSS are well formed", {
  preview <- as.character(glanceSpinkit())
  expect_no_match(preview, ":;", fixed = TRUE)
  expect_match(preview, "background-color:#fff;", fixed = TRUE)
  expect_match(as.character(glanceLoaders()), "sby-loader", fixed = TRUE)
  expect_match(spinner_css("#fff", "example"), "^@-webkit-keyframes load5-example")
})
