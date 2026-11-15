# Regression tests for the 2026-11 pre-CRAN audit findings.

fx_session <- function() {
  e <- new.env(parent = emptyenv())
  e$messages <- list()
  e$ns <- identity
  e$sendCustomMessage <- function(type, message) {
    e$messages[[length(e$messages) + 1L]] <- list(type = type, message = message)
  }
  e
}

fx_head <- function(x) as.character(htmltools::renderTags(x)$head)
fx_html <- function(x) as.character(htmltools::renderTags(x)$html)
fx_js <- function(path) {
  paste(readLines(system.file(path, package = "standby"), warn = FALSE),
        collapse = "\n")
}

# H01 -------------------------------------------------------------------------

test_that("H01: loader handlers do not build selectors from output ids", {
  standby_js <- fx_js("standby/js/standby.js")
  expect_match(standby_js, "event.target", fixed = TRUE)
  expect_no_match(standby_js, "querySelector")
  expect_no_match(standby_js, "'#' +", fixed = TRUE)

  microtip_js <- fx_js("microtip/js/microtip.js")
  expect_match(microtip_js, "document.getElementById(String(message.id))",
               fixed = TRUE)
  expect_no_match(microtip_js, "querySelector")
})

# H03 -------------------------------------------------------------------------

test_that("H03: spinkit colours are scoped to each widget", {
  a <- htmltools::renderTags(spinkit(shiny::div(), type = "chase", color = "red"))
  b <- htmltools::renderTags(spinkit(shiny::div(), type = "chase", color = "blue"))

  id_a <- sub('.*id="([^"]+)".*', "\\1", as.character(a$html))
  id_b <- sub('.*id="([^"]+)".*', "\\1", as.character(b$html))
  expect_true(nzchar(id_a))
  expect_true(nzchar(id_b))
  expect_false(id_a == id_b)
  expect_match(as.character(a$html), paste0('id="', id_a, '"'), fixed = TRUE)
  expect_match(as.character(b$html), paste0('id="', id_b, '"'), fixed = TRUE)

  head_a <- as.character(a$head)
  head_b <- as.character(b$head)
  expect_match(head_a, paste0("#", id_a, " \\.sk-chase-dot:before \\{background-color: #FF0000;\\}"))
  expect_match(head_b, paste0("#", id_b, " \\.sk-chase-dot:before \\{background-color: #0000FF;\\}"))
  # The global rules that made the last widget win are gone.
  expect_no_match(head_a, "(^|[}>])[[:space:]]*\\.sk-chase-dot:before")
  expect_no_match(head_b, "(^|[}>])[[:space:]]*\\.sk-chase-dot:before")

  # The same scoping applies to the other pseudo-element types.
  for (type in c("circle", "circle-fade", "fold")) {
    css <- fx_head(spinkit(shiny::div(), type = type, color = "red"))
    expect_match(css, "#spinkit-[0-9]+ \\.sk-")
  }
})

# H04 -------------------------------------------------------------------------

test_that("H04: threeDots sets --primary-color on the widget", {
  out <- htmltools::renderTags(threeDots(shiny::div(), type = "carousel",
                                         color = "red"))
  id <- sub('.*id="([^"]+)".*', "\\1", as.character(out$html))
  head <- as.character(out$head)
  expect_match(head, paste0("#", id, ".*--primary-color: #FF0000"))
  expect_match(head, paste0("#", id, ".*color: #FF0000"))

  css <- fx_js("three-dots/css/three-dots.css")
  expect_match(css, "box-shadow: [^;]*var\\(--primary-color\\)")
})

# H05 -------------------------------------------------------------------------

test_that("H05: colour names use one interpretation for main colour and shades", {
  css <- fx_head(spinners(shiny::div(), type = 8, color = "green"))
  expect_match(css, "border-left-color: #00FF00;", fixed = TRUE)
  expect_match(css, "border-top-color: rgba(0,255,0,0.2);", fixed = TRUE)
  expect_no_match(css, "border-left-color: green")

  css <- fx_head(spinners(shiny::div(), type = 5, color = "purple"))
  expect_match(css, "#A020F0", fixed = TRUE)
  expect_match(css, "rgba(160, 32, 240, 0.2)", fixed = TRUE)

  # R-only names used to be emitted literally and silently ignored by CSS.
  for (colour in c("gray50", "green3")) {
    css <- fx_head(spinners(shiny::div(), type = 1, color = colour))
    expect_no_match(css, colour)
    expect_match(css, "#7F7F7F|#00CD00")
  }
  css <- fx_head(spinners(shiny::div(), type = 1, color = "gray50"))
  expect_match(css, "#7F7F7F", fixed = TRUE)
})

# H06 -------------------------------------------------------------------------

test_that("H06: valid documented CSS colours are accepted", {
  colours <- c(
    "rebeccapurple",
    "hsl(-120,100%,50%)",
    "hsl(120deg,100%,50%)",
    "rgb(255 0 0 / 50%)",
    "hsl(240 100% 50% / 25%)",
    "rgb(100% 0% 0%)",
    "rgb(0 0 255 / 0.25)"
  )
  for (colour in colours) {
    expect_no_error(spinners(shiny::div(), type = 1, color = colour))
    expect_no_error(spinners(shiny::div(), type = 8, color = colour))
    expect_no_error(threeDots(shiny::div(), color = colour))
    expect_no_error(spinkit(shiny::div(), type = "chase", color = colour))
    expect_no_error(vizLoad(shiny::div(), type = "circles", color = colour))
  }

  expect_equal(unname(spinner_color_rgb("rebeccapurple")), c(102, 51, 153))
  expect_equal(unname(spinner_color_rgb("hsl(-120,100%,50%)")), c(0, 0, 255))
  expect_equal(unname(spinner_color_rgb("hsl(120deg,100%,50%)")), c(0, 255, 0))

  # Stylesheet/HTML delimiters are still rejected.
  for (bad in c("red; background: blue", "red</style>", "rgb(1 2 / 50%)",
                "url(http://example.com/x.png)", "hsl(0,0%,0%)}")) {
    expect_error(validate_color(bad, "color"), "Invalid `color`")
  }
})

# H07 -------------------------------------------------------------------------

test_that("H07: spinner shades preserve the requested alpha", {
  css <- fx_head(spinners(shiny::div(), type = 8, color = "rgba(255,0,0,0)"))
  expect_match(css, "border-left-color: rgba(255,0,0,0);", fixed = TRUE)
  expect_no_match(css, "0.2")

  css <- fx_head(spinners(shiny::div(), type = 8, color = "rgba(255,0,0,0.5)"))
  expect_match(css, "rgba(255,0,0,0.1)", fixed = TRUE)

  css <- fx_head(spinners(shiny::div(), type = 5, color = "rgba(255,0,0,0.5)"))
  expect_match(css, "rgba(255, 0, 0, 0.1)", fixed = TRUE)
  expect_match(css, "rgba(255, 0, 0, 0.25)", fixed = TRUE)
  expect_match(css, "rgba(255, 0, 0, 0.35)", fixed = TRUE)

  css <- fx_head(spinners(shiny::div(), type = 8, color = "#ff000080"))
  expect_match(css, "0.1004", fixed = TRUE)

  css <- fx_head(spinners(shiny::div(), type = 8, color = "#ff000000"))
  expect_match(css, "rgba(255,0,0,0)", fixed = TRUE)

  css <- fx_head(spinners(shiny::div(), type = 8, color = "hsla(0,100%,50%,0.5)"))
  expect_match(css, "rgba(255,0,0,0.1)", fixed = TRUE)
})

# H08 -------------------------------------------------------------------------

test_that("H08: channels are quantised half-up like CSS", {
  expect_equal(unname(spinner_color_rgb("rgb(30%,0%,0%)")), c(77, 0, 0))
  expect_equal(unname(spinner_color_rgb("hsl(0,0%,30%)")), c(77, 77, 77))
  expect_equal(unname(spinner_color_rgb("rgb(70%,0%,0%)")), c(179, 0, 0))
  expect_equal(unname(spinner_color_rgb("#4d4d4d")), c(77, 77, 77))

  # The shade uses the same channel value as the main colour.
  css <- fx_head(spinners(shiny::div(), type = 8, color = "rgb(30%,0%,0%)"))
  expect_match(css, "border-left-color: rgb(30%,0%,0%);", fixed = TRUE)
  expect_match(css, "rgba(77,0,0,0.2)", fixed = TRUE)
})

# H09/H10/H11/H12 -------------------------------------------------------------

test_that("H09: notify() sends FALSE, not JSON null, for absent text/title", {
  session <- fx_session()
  notify(session = session)
  p <- session$messages[[1]]$message
  expect_identical(p$title, "Hey")
  expect_identical(p$text, FALSE)
  expect_false(p$titleTrusted)
  expect_false(p$textTrusted)

  session <- fx_session()
  notify(title = NULL, text = NULL, session = session)
  p <- session$messages[[1]]$message
  expect_identical(p$title, FALSE)
  expect_identical(p$text, FALSE)
})

test_that("H10: notify() renders element inputs to trusted HTML", {
  session <- fx_session()
  notify(title = shiny::strong("Bold"), text = shiny::span("Text"),
         session = session)
  p <- session$messages[[1]]$message
  expect_identical(p$title, "<strong>Bold</strong>")
  expect_identical(p$text, "<span>Text</span>")
  expect_true(p$titleTrusted)
  expect_true(p$textTrusted)

  session <- fx_session()
  notify(title = "Plain <b>text</b>", text = "Body", session = session)
  p <- session$messages[[1]]$message
  expect_identical(p$title, "Plain <b>text</b>")
  expect_false(p$titleTrusted)
})

test_that("H11: notify(delay = 'infinity') disables automatic hiding", {
  session <- fx_session()
  notify(delay = "infinity", session = session)
  p <- session$messages[[1]]$message
  expect_false(p$hide)
  expect_equal(p$delay, 8000)

  session <- fx_session()
  notify(delay = Inf, session = session)
  expect_false(session$messages[[1]]$message$hide)

  session <- fx_session()
  notify(delay = 5000, session = session)
  expect_true(session$messages[[1]]$message$hide)
})

test_that("H12: the translucent class has shipped styling", {
  css_file <- system.file("pnotify/css/sbyNotify.css", package = "standby")
  expect_true(nzchar(css_file))
  css <- paste(readLines(css_file, warn = FALSE), collapse = "\n")
  expect_match(css, ".pnotify.translucent", fixed = TRUE)
  expect_match(css, "opacity: 0.7", fixed = TRUE)
})

# H13/H14 ---------------------------------------------------------------------

test_that("H13: microTip removes a stale size when size is NULL", {
  js <- fx_js("microtip/js/microtip.js")
  expect_match(js, "removeAttribute('data-microtip-size')", fixed = TRUE)
  expect_match(js, "getElementById", fixed = TRUE)
})

test_that("H14: bootBox uses a dialog so onEscape is respected", {
  js <- fx_js("bootbox/js/sbyBootbox.js")
  expect_match(js, "bootbox.dialog(", fixed = TRUE)
  expect_no_match(js, "bootbox.alert(", fixed = TRUE)
  expect_match(js, "onEscape: message.onEscape", fixed = TRUE)
  expect_match(js, "buttons:", fixed = TRUE)
})

# H15/H16/H17 -----------------------------------------------------------------

test_that("H15: toast image width is always a usable CSS length", {
  session <- fx_session()
  toast(title = "t", message = "m", image = "x", session = session)
  expect_identical(session$messages[[1]]$message$imageWidth, "50px")

  session <- fx_session()
  toast(title = "t", message = "m", image = "x", image_width = "50px",
        session = session)
  expect_identical(session$messages[[1]]$message$imageWidth, "50px")

  session <- fx_session()
  toast(title = "t", message = "m", image = "x", image_width = 120,
        session = session)
  expect_identical(session$messages[[1]]$message$imageWidth, "120px")
})

test_that("H16: toast font sizes and line heights are normalised per value", {
  session <- fx_session()
  toast(title = "t", message = "m", title_size = 14, title_line_height = "2em",
        message_size = 24, message_line_height = "2em", session = session)
  p <- session$messages[[1]]$message
  expect_identical(p$titleSize, "14px")
  expect_identical(p$titleLineHeight, "2em")
  expect_identical(p$messageSize, "24px")
  expect_identical(p$messageLineHeight, "2em")

  # An unset title_size must not affect the message options.
  session <- fx_session()
  toast(title = "t", message = "m", message_size = 24,
        message_line_height = "2em", session = session)
  p <- session$messages[[1]]$message
  expect_null(p$titleSize)
  expect_identical(p$messageSize, "24px")
  expect_identical(p$messageLineHeight, "2em")

  js <- fx_js("toast/js/iziToast.min.js")
  expect_no_match(js, "isNaN(s.titleSize)")
  expect_match(js, "isNaN(s.titleLineHeight)", fixed = TRUE)
  expect_match(js, "isNaN(s.messageSize)", fixed = TRUE)
  expect_match(js, "isNaN(s.messageLineHeight)", fixed = TRUE)
})

test_that("H17: toast display_mode implements the documented modes", {
  for (mode in 0:2) {
    session <- fx_session()
    toast(title = "t", message = "m", display_mode = mode, session = session)
    expect_identical(session$messages[[1]]$message$displayMode, as.integer(mode))
  }
  expect_error(toast(display_mode = 3, session = fx_session()),
               "display_mode")

  js <- fx_js("toast/js/sbyToast.js")
  expect_match(js, "queue.push", fixed = TRUE)
  expect_match(js, "replaceAll", fixed = TRUE)
})

# H18 -------------------------------------------------------------------------

test_that("H18: previewSpinners('vizload') renders the vizload loader", {
  f <- previewSpinners
  environment(f) <- list2env(list(interactive = function() TRUE),
                             parent = environment(f))
  x <- htmltools::renderTags(f("vizload"))
  html <- as.character(x$html)
  expect_match(html, "lv-bars", fixed = TRUE)
  expect_gte(length(gregexpr("<div></div>", html, fixed = TRUE)[[1]]), 8)

  expect_error(previewSpinners("vizLoad"), "should be one of")
  expect_error(previewAlerts("bogus"), "should be one of")
})

# H19 -------------------------------------------------------------------------

test_that("H19: CSS Loaders base rules do not target the spinner .loader", {
  html <- fx_html(loaders(shiny::div()))
  expect_match(html, "loader sby-loader", fixed = TRUE)

  css <- fx_js("loaders/css/loaders.css")
  expect_match(css, ".loader.sby-loader {", fixed = TRUE)
  expect_match(css, ".loader.sby-loader:before", fixed = TRUE)
  expect_no_match(css, "(^|\\n)\\.loader \\{")
  expect_no_match(css, "(^|\\n)\\.loader:before")
})

# M01/M03/M04/L01 -------------------------------------------------------------

test_that("M01 + M03: DESCRIPTION metadata", {
  d <- read.dcf(system.file("DESCRIPTION", package = "standby"))
  expect_true(grepl("aravindhebbali@rsquaredacademy.com", d[, "Authors@R"],
                    fixed = TRUE))
  expect_true(grepl("testthat (>= 3.1.5)", d[, "Suggests"], fixed = TRUE))
  expect_identical(unname(d[, "Version"]), "0.2.2")
})

test_that("M04: alertify alert types have a defined effect", {
  css_file <- system.file("alertify/css/sbyAlertify.css", package = "standby")
  expect_true(nzchar(css_file))
  css <- paste(readLines(css_file, warn = FALSE), collapse = "\n")
  for (type in c("success", "warning", "error", "message")) {
    expect_match(css, paste0(".ajs-dialog.sby-alert-", type), fixed = TRUE)
  }
  js <- fx_js("alertify/js/sbyAlertify.js")
  expect_match(js, "sby-alert-' + dialogType", fixed = TRUE)
})

test_that("L01: the unavailable tinyverse badge is gone", {
  readme <- paste(readLines(system.file("README.md", package = "standby"),
                            warn = FALSE), collapse = "\n")
  expect_no_match(readme, "tinyverse")

  # README.Rmd is excluded from the built package; check it when present.
  rmd_path <- system.file("README.Rmd", package = "standby")
  if (nzchar(rmd_path)) {
    readme_rmd <- paste(readLines(rmd_path, warn = FALSE), collapse = "\n")
    expect_no_match(readme_rmd, "tinyverse")
  }
})
