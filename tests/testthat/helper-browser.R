# Browser-level regression helpers. These tests use a real Chrome through
# chromote, so they are skipped on CRAN and when Chrome/chromote are missing.

fxb_available <- function() {
  skip_on_cran()
  skip_if_not_installed("chromote")
  if (identical(tolower(Sys.getenv("STANDBY_BROWSER_TESTS")), "false")) {
    skip("STANDBY_BROWSER_TESTS=false")
  }
  if (!fxb_chrome_ok()) {
    skip("Chrome is not available or did not start")
  }
  invisible(TRUE)
}

# Probe Chrome once per test run: a missing Chrome, or one whose debugging
# port does not open in time (seen on CI runners), skips the browser tests
# instead of failing them.
fxb_chrome_ok <- local({
  ok <- NULL
  function() {
    if (is.null(ok)) {
      ok <<- tryCatch({
        if (is.null(chromote::find_chrome())) stop("no Chrome")
        s <- chromote::ChromoteSession$new()
        s$close()
        TRUE
      }, error = function(e) FALSE)
    }
    ok
  }
})

fxb_read <- function(path) {
  paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
}

fxb_file <- function(...) {
  system.file(..., package = "standby", mustWork = TRUE)
}

fxb_render <- function(x) {
  rt <- htmltools::renderTags(x)
  list(html = as.character(rt$html), head = as.character(rt$head))
}

fxb_page <- function(body = "", head = "", css = character(),
                     js = character(), jquery = FALSE) {
  css_text <- paste(vapply(css, fxb_read, character(1)), collapse = "\n")
  js_text <- paste(vapply(js, fxb_read, character(1)), collapse = "\n")
  jquery_tag <- if (isTRUE(jquery)) {
    paste0("<script>", fxb_read(file.path(
      system.file("www/shared", package = "shiny"), "jquery.min.js"
    )), "</script>")
  } else {
    ""
  }
  paste0(
    "<!DOCTYPE html><html><head><meta charset='utf-8'>",
    "<style>body{margin:0;padding:0}", css_text, "</style>",
    jquery_tag,
    "<script>window.Shiny={handlers:{},addCustomMessageHandler:",
    "function(type,fn){this.handlers[type]=fn;}};</script>",
    "<script>", js_text, "</script>",
    head,
    "</head><body>", body, "</body></html>"
  )
}

fxb_open <- function(html) {
  session <- chromote::ChromoteSession$new()
  file <- tempfile(fileext = ".html")
  writeLines(html, file, useBytes = TRUE)
  path <- gsub("\\\\", "/", normalizePath(file))
  url <- paste0("file:///", utils::URLencode(path))
  session$Page$navigate(url)
  deadline <- Sys.time() + 10
  repeat {
    ready <- tryCatch(
      session$Runtime$evaluate("document.readyState")$result$value,
      error = function(e) NULL
    )
    if (identical(ready, "complete")) break
    if (Sys.time() > deadline) stop("page did not finish loading")
    Sys.sleep(0.05)
  }
  session
}

fxb_eval <- function(session, js, await = FALSE) {
  result <- session$Runtime$evaluate(js, awaitPromise = await,
                                     returnByValue = TRUE)
  if (!is.null(result$exceptionDetails)) {
    details <- result$exceptionDetails
    message <- details$text
    if (!is.null(details$exception$description)) {
      message <- paste0(message, "\n", details$exception$description)
    }
    stop("JavaScript error: ", message, call. = FALSE)
  }
  result$result$value
}

fxb_wait <- function(session, ms) {
  fxb_eval(
    session,
    sprintf("new Promise(function (resolve) { setTimeout(resolve, %d); })", ms),
    await = TRUE
  )
  invisible(NULL)
}

fxb_payload <- function(fun, ...) {
  session <- new.env(parent = emptyenv())
  session$messages <- list()
  session$ns <- identity
  session$sendCustomMessage <- function(type, message) {
    session$messages[[length(session$messages) + 1L]] <-
      list(type = type, message = message)
  }
  fun(..., session = session)
  jsonlite::toJSON(session$messages[[1]]$message, auto_unbox = TRUE,
                   null = "null")
}

fxb_notify_page <- function() {
  fxb_open(fxb_page(
    js = c(fxb_file("pnotify/js/PNotify.js"),
           fxb_file("pnotify/js/notify.js")),
    css = c(fxb_file("pnotify/css/PNotify.css"),
            fxb_file("pnotify/css/BrightTheme.css"),
            fxb_file("pnotify/css/sbyNotify.css"))
  ))
}

fxb_toast_page <- function() {
  fxb_open(fxb_page(
    js = c(fxb_file("toast/js/iziToast.min.js"),
           fxb_file("toast/js/sbyToast.js")),
    css = fxb_file("toast/css/iziToast.min.css")
  ))
}
