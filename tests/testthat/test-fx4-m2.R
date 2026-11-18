fx4_choices <- list(
  list(alertify_alert, "type", c("success", "error", "warning", "message")),
  list(alertify_alert, "transition", c("pulse", "slide", "zoom", "fade", "flipx", "flipy")),
  list(alertify_notify, "type", c("success", "error", "warning", "message")),
  list(alertify_notify, "position", c("bottom-right", "bottom-left", "bottom-center", "top-right", "top-left", "top-center")),
  list(bootBox, "size", c("small", "sm", "large", "lg", "extra-large", "xl", "")),
  list(tingle, "button_type", c("default", "primary", "danger")),
  list(tingle, "button_position", c("right", "left")),
  list(notify, "type", c("notice", "info", "success", "error")),
  list(notify, "animation", c("none", "fade")),
  list(notify, "animate_speed", c("slow", "normal", "fast")),
  list(toast, "type", c("info", "success", "warning", "error", "question")),
  list(toast, "position", c("bottomRight", "bottomLeft", "topRight", "topLeft", "topCenter", "bottomCenter", "center")),
  list(toast, "layout", c(1, 2, 3)),
  list(toast, "transition_in", c("bounceInLeft", "bounceInRight", "bounceInUp", "bounceInDown", "fadeIn", "fadeInDown", "fadeInUp", "fadeInLeft", "fadeInRight", "flipInX", "revealIn", "slideIn", "")),
  list(toast, "transition_out", c("fadeOut", "fadeOutDown", "fadeOutUp", "fadeOutLeft", "fadeOutRight", "flipOutX", "")),
  list(notice, "type", c("notice", "success", "warning", "error")),
  list(notice, "layout", c("growl", "attached", "bar")),
  list(microTip, "position", c("top", "bottom", "left", "right", "top-left", "top-right", "bottom-left", "bottom-right")),
  list(microTip, "size", c("fit", "small", "medium", "large", ""))
)

test_that("fx4 M2: eight senders reject invalid choices and name valid values", {
  for (spec in fx4_choices) {
    for (value in list("bogus", NA, character(), c("a", "b"), list("x"))) {
      args <- setNames(list(value), spec[[2]])
      error <- tryCatch(do.call(fxb_payload, c(list(fun = spec[[1]]), args)), error = identity)
      expect_s3_class(error, "error")
      if (inherits(error, "error")) {
        expect_match(conditionMessage(error), paste0("`", spec[[2]], "`"), fixed = TRUE)
        for (choice in spec[[3]][nzchar(as.character(spec[[3]]))]) {
          expect_match(conditionMessage(error), as.character(choice), fixed = TRUE)
        }
      }
    }
    for (value in spec[[3]]) {
      expect_no_error(do.call(fxb_payload, c(list(fun = spec[[1]]), setNames(list(value), spec[[2]]))))
    }
  }
  expect_error(fxb_payload(notice, effect = "bogus"), "`effect` must be one of:", fixed = TRUE)
})

test_that("fx4 M2: logical arguments reject missing and vector conditions", {
  flags <- list(
    list(alertify_alert, c("transition_off", "closable", "auto_reset", "frameless",
      "maximizable", "modal", "movable", "move_bounded", "overflow", "padding",
      "pinnable", "resizeable", "start_maximized")),
    list(bootBox, c("close_on_escape", "show", "backdrop", "close_button", "animate")),
    list(tingle, "close_button"),
    list(notify, c("icon", "hide", "sticker", "closer", "shadow", "mouse_reset", "translucent", "non_blocking")),
    list(toast, c("balloon", "close", "close_on_escape", "close_on_click", "rtl",
      "drag_to_close", "pause_on_hover", "reset_on_hover", "overlay", "overlay_close", "animate_inside")))
  for (spec in flags) {
    for (arg in spec[[2]]) {
      for (value in list(NA, c(TRUE, FALSE), "bogus")) {
        if (arg == "icon" && is.character(value)) next
        expect_error(do.call(fxb_payload, c(list(fun = spec[[1]]), setNames(list(value), arg))),
                     paste0("`", arg, "` must be TRUE or FALSE"), fixed = TRUE)
      }
      for (value in c(TRUE, FALSE)) {
        expect_no_error(do.call(fxb_payload, c(list(fun = spec[[1]]), setNames(list(value), arg))))
      }
    }
  }
})

test_that("fx4 M2: delays validate numeric values and preserve supported sentinels", {
  for (spec in list(list(alertify_notify, "delay"), list(notify, "delay"), list(toast, "duration"))) {
    for (value in list("abc", NA, NaN, -Inf, c(1, 2), TRUE)) {
      if (identical(spec[[1]], notify) && identical(value, Inf)) next
      # rx5 R4/L-1: alertify and toast treat NA/NaN/-Inf as "stay open" (0.2.1 behaviour)
      if (!identical(spec[[1]], notify) && length(value) == 1L && (is.na(value) || identical(value, -Inf))) next
      expect_error(do.call(fxb_payload, c(list(fun = spec[[1]]), setNames(list(value), spec[[2]]))),
                   paste0("`", spec[[2]], "` must be a single finite"), fixed = TRUE)
    }
    for (value in list(0, 1.5, "1000")) {
      expect_no_error(do.call(fxb_payload, c(list(fun = spec[[1]]), setNames(list(value), spec[[2]]))))
    }
  }
  for (value in list(FALSE, NULL, 0)) {
    p <- jsonlite::fromJSON(fxb_payload(toast, duration = value))
    expect_equal(p$timeout, value)
  }
  for (value in list("infinity", "infinite", Inf)) {
    p <- jsonlite::fromJSON(fxb_payload(notify, delay = value))
    expect_false(p$hide)
  }
  expect_equal(jsonlite::fromJSON(fxb_payload(alertify_notify, delay = -1))$delay, -1)
  expect_error(fxb_payload(toast, duration = -1), "`duration`", fixed = TRUE)
  expect_error(fxb_payload(notify, delay = -1), "`delay`", fixed = TRUE)
})

test_that("fx4 M2: dimensions, Bootbox aliases and empty content reach JS safely", {
  p <- jsonlite::fromJSON(fxb_payload(notify, width = 500, min_height = 20,
                                    max_text_height = 250, icon = "custom-icon"))
  expect_identical(p$width, "500px")
  expect_identical(p$minHeight, "20px")
  expect_identical(p$maxTextHeight, "250px")
  expect_identical(p$icon, "custom-icon")
  p <- jsonlite::fromJSON(fxb_payload(notify, width = "calc(100vw - 20px)", max_text_height = NULL))
  expect_identical(p$width, "calc(100vw - 20px)")
  expect_null(p$maxTextHeight)
  for (value in list(NULL, "", NA, character(), c("a", "b"), FALSE, 0)) {
    expect_error(fxb_payload(bootBox, message = value), "`message` must be non-empty text or HTML", fixed = TRUE)
  }
  for (alias in c("sm", "lg", "xl")) {
    p <- jsonlite::fromJSON(fxb_payload(bootBox, size = alias))
    expect_identical(p$size, c(sm = "small", lg = "large", xl = "extra-large")[[alias]])
  }
  for (value in list(NULL, "static", "STATIC", TRUE, FALSE)) {
    expect_no_error(fxb_payload(bootBox, backdrop = value, size = NULL))
  }
  expect_identical(jsonlite::fromJSON(fxb_payload(tingle, content = NULL))$content, "")
  expect_identical(jsonlite::fromJSON(fxb_payload(toast, layout = "2"))$layout, 2L)
})

test_that("fx4 M2: the bundled question toast type reaches iziToast", {
  fxb_available()
  s <- fxb_toast_page()
  on.exit(s$close())
  payload <- fxb_payload(toast, title = "Question", message = "Continue?",
                         type = "question", duration = FALSE)
  fxb_eval(s, paste0("Shiny.handlers['toast.send'](", payload, ");"))
  expect_true(fxb_eval(s, "!!document.querySelector('.iziToast.iziToast-color-yellow')"))
})
