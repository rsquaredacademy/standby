spinner_css_head <- function(...) {
  as.character(htmltools::renderTags(spinners(...))$head)
}

shade_colours <- function(css) {
  regmatches(css, gregexpr("rgba?\\([^)]*\\)", css))[[1]]
}

normalise_spinner_ids <- function(css) {
  gsub("spinner-[0-9]+", "spinner-ID", css)
}

test_that("spinners() validates type against supported values", {
  allowed <- "must be one of 1, 2, 3, 4, 5, 6, 7, 8"

  expect_error(spinners("x", type = 9), allowed)
  expect_error(spinners("x", type = 0), allowed)
  expect_error(spinners("x", type = "load1"), allowed)
  expect_error(spinners("x", type = "9"), allowed)
  expect_error(spinners("x", type = "a"), allowed)
  expect_error(spinners("x", type = ""), allowed)
  expect_error(spinners("x", type = TRUE), allowed)
})

test_that("spinners() accepts type as a numeric string", {
  for (type in c("4", " 8 ")) {
    expect_equal(
      normalise_spinner_ids(spinner_css_head(spinners("x", type = type))),
      normalise_spinner_ids(spinner_css_head(spinners("x", type = as.integer(type))))
    )
  }
})

test_that("spinners() types 5 and 8 accept functional colour notation", {
  colours <- c(
    "rgba(0,0,0,.5)",
    "rgb(255,0,0)",
    "hsl(120, 100%, 50%)",
    "hsla(120,100%,50%,0.3)"
  )

  for (type in c(5, 8)) {
    for (colour in colours) {
      expect_no_error(spinners("x", type = type, color = colour))

      css <- spinner_css_head(spinners("x", type = type, color = colour))
      shades <- shade_colours(css)

      expect_gt(length(shades), 0)
      for (shade in shades) {
        expect_no_error(validate_color(shade, "shade"))
      }
    }
  }

  # hsl()/hsla() are converted to RGB components for the generated shades.
  expect_match(
    spinner_css_head(spinners("x", type = 5, color = "hsl(120, 100%, 50%)")),
    "rgba\\(0, 255, 0, 0\\.2\\)"
  )
  expect_match(
    spinner_css_head(spinners("x", type = 8, color = "hsl(120, 100%, 50%)")),
    "rgba\\(0,255,0,0\\.2\\)"
  )

  # rgb()/rgba() keep their RGB components and use every shade alpha.
  for (alpha in c("0.2", "0.5", "0.7")) {
    expect_match(
      spinner_css_head(spinners("x", type = 5, color = "rgb(255,0,0)")),
      paste0("rgba\\(255, 0, 0, ", gsub("\\.", "\\\\.", alpha), "\\)")
    )
  }
})

test_that("hex and named colours keep their CSS for all spinner types", {
  for (colour in c("#0275d8", "red")) {
    for (type in 1:8) {
      expect_no_error(spinners("x", type = type, color = colour))
    }
  }

  css5_hex <- spinner_css_head(spinners("x", type = 5, color = "#0275d8"))
  expect_match(css5_hex, "rgba\\(2, 117, 216, 0\\.2\\)")
  expect_match(css5_hex, "rgba\\(2, 117, 216, 0\\.5\\)")
  expect_match(css5_hex, "rgba\\(2, 117, 216, 0\\.7\\)")

  css8_hex <- spinner_css_head(spinners("x", type = 8, color = "#0275d8"))
  expect_match(css8_hex, "rgba\\(2,117,216,0\\.2\\)")

  css5_named <- spinner_css_head(spinners("x", type = 5, color = "red"))
  expect_match(css5_named, "rgba\\(255, 0, 0, 0\\.2\\)")

  css8_named <- spinner_css_head(spinners("x", type = 8, color = "red"))
  expect_match(css8_named, "rgba\\(255,0,0,0\\.2\\)")
})
