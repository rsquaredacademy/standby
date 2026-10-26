fake_session <- function() {
  e <- new.env(parent = emptyenv())
  e$messages <- list()
  e$ns <- identity
  e$sendCustomMessage <- function(type, message) {
    e$messages[[length(e$messages) + 1L]] <- list(type = type, message = message)
  }
  e
}

test_that("C1: two threeDots() calls have different ids and scoped CSS", {
  t1 <- htmltools::renderTags(threeDots(shiny::div("first"), color = "red"))
  t2 <- htmltools::renderTags(threeDots(shiny::div("second"), color = "blue"))

  id1 <- sub('.*id="([^"]+)".*', "\\1", as.character(t1$html))
  id2 <- sub('.*id="([^"]+)".*', "\\1", as.character(t2$html))

  expect_true(nchar(id1) > 0)
  expect_true(nchar(id2) > 0)
  expect_false(id1 == id2)

  head1 <- as.character(t1$head)
  head2 <- as.character(t2$head)

  expect_match(head1, paste0("#", id1, ".*color: red"))
  expect_match(head2, paste0("#", id2, ".*color: blue"))
  expect_false(grepl(paste0("#", id2), head1))
  expect_false(grepl(paste0("#", id1), head2))
})

test_that("C2: two loaders() calls have different ids", {
  l1 <- htmltools::renderTags(loaders(shiny::div("first")))
  l2 <- htmltools::renderTags(loaders(shiny::div("second")))

  id1 <- sub('.*id="([^"]+)".*', "\\1", as.character(l1$html))
  id2 <- sub('.*id="([^"]+)".*', "\\1", as.character(l2$html))

  expect_true(nchar(id1) > 0)
  expect_true(nchar(id2) > 0)
  expect_false(id1 == id2)
})

test_that("N9: loaders() and threeDots() error on invalid type", {
  expect_error(threeDots(shiny::div("test"), type = "bogus"), "should be one of")
  expect_error(loaders(shiny::div("test"), type = "bogus"), "should be one of")
  expect_error(vizLoad(shiny::div("test"), type = "bogus"), "should be one of")
})

test_that("N6: vizLoad() validates size per type and errors on unsupported combinations", {
  # line / bordered_line do not support tiny
  expect_error(
    vizLoad(shiny::div("test"), type = "line", size = "tiny"),
    "not supported"
  )
  expect_error(
    vizLoad(shiny::div("test"), type = "bordered_line", size = "tiny"),
    "not supported"
  )

  # other types do not support fluid
  unsupported_fluid <- c("bars", "squares", "circles", "dots", "spinner", "dashed")
  for (tp in unsupported_fluid) {
    expect_error(
      vizLoad(shiny::div("test"), type = tp, size = "fluid"),
      "not supported"
    )
  }

  # invalid size string errors
  expect_error(
    vizLoad(shiny::div("test"), type = "bars", size = "bogus"),
    "not supported"
  )
})

test_that("N7: vizLoad() small/tiny replaces lvl-5 offset with lv-mid", {
  types_sm_tiny <- c("bars", "squares", "circles", "dots", "spinner", "dashed")
  for (tp in types_sm_tiny) {
    res_sm <- as.character(htmltools::renderTags(vizLoad(shiny::div("test"), type = tp, size = "small"))$html)
    res_tiny <- as.character(htmltools::renderTags(vizLoad(shiny::div("test"), type = tp, size = "tiny"))$html)

    expect_match(res_sm, "sm lv-mid")
    expect_no_match(res_sm, "lvl-5")

    expect_match(res_tiny, "tiny lv-mid")
    expect_no_match(res_tiny, "lvl-5")
  }

  # line and bordered_line small sizes still have lv-mid
  res_line_sm <- as.character(htmltools::renderTags(vizLoad(shiny::div("test"), type = "line", size = "small"))$html)
  expect_match(res_line_sm, "sm lv-mid")

  res_bline_sm <- as.character(htmltools::renderTags(vizLoad(shiny::div("test"), type = "bordered_line", size = "small"))$html)
  expect_match(res_bline_sm, "sm lv-mid")
})

test_that("N4: vizLoad(type = 'dots', color = ...) applies color inline", {
  res <- as.character(htmltools::renderTags(vizLoad(shiny::div("test"), type = "dots", color = "red"))$html)
  expect_match(res, 'style="background-color:red;"')

  # Check that each dot has the color
  matches <- gregexpr('style="background-color:red;"', res)[[1]]
  expect_equal(length(matches), 4)

  # Check validation works for dots
  expect_error(
    vizLoad(shiny::div("test"), type = "dots", color = "red</style><script>alert(1)</script><style>"),
    "Invalid `color`"
  )
})

test_that("N5 + C12: alertify_alert() payload contains expected keys and preserves R argument names", {
  session <- fake_session()
  alertify_alert(
    title = "Test Title",
    message = "Test Message",
    btn_label = "Confirm",
    type = "warning",
    maximizable = TRUE,
    resizeable = TRUE,
    session = session
  )

  expect_equal(length(session$messages), 1)
  msg <- session$messages[[1]]
  expect_equal(msg$type, "alertify.alert")

  p <- msg$message
  expect_equal(p$title, "Test Title")
  expect_equal(p$message, "Test Message")
  expect_equal(p$label, "Confirm")
  expect_equal(p$type, "warning")
  expect_true(p$maximizable)
  expect_true(p$resizeable)
})

test_that("C11: toast(type = ...) includes type in payload", {
  session <- fake_session()
  toast(title = "Title", message = "Msg", type = "success", session = session)

  expect_equal(length(session$messages), 1)
  p <- session$messages[[1]]$message
  expect_true("type" %in% names(p))
  expect_equal(p$type, "success")

  session2 <- fake_session()
  toast(title = "Title", message = "Msg", type = "error", session = session2)
  expect_equal(session2$messages[[1]]$message$type, "error")
})

test_that("C13: bootBox() with class = NULL produces no animation classes", {
  session <- fake_session()
  bootBox(message = "test", class = NULL, session = session)

  expect_equal(length(session$messages), 1)
  p <- session$messages[[1]]$message
  expect_null(p$className)

  session2 <- fake_session()
  bootBox(message = "test", class = "fadeIn", session = session2)
  expect_equal(session2$messages[[1]]$message$className, "animate__animated animate__fadeIn")
})

test_that("N8: doc defaults match code defaults for toast() and notify()", {
  expect_equal(formals(toast)$position, "center")
  expect_equal(formals(notify)$title, "Hey")
  expect_null(formals(notify)$text)
})
