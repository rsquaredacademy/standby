test_that("fx5 R1: infinite toast duration disables automatic closing", {
  for (value in list(Inf, c(wait = Inf), "infinity", "infinite")) {
    p <- jsonlite::fromJSON(fxb_payload(toast, duration = value))
    expect_identical(p$timeout, FALSE)
  }
})

test_that("fx5 R2: infinite and NULL Alertify delays keep notices open", {
  for (value in list(Inf, NULL, c(wait = Inf), "infinity", "infinite")) {
    p <- jsonlite::fromJSON(fxb_payload(alertify_notify, delay = value))
    expect_equal(p$delay, 0)
  }
})

test_that("fx5 delay sentinels reject complex infinity with a named error", {
  for (fun in list(alertify_notify, notify, toast)) {
    arg <- if (identical(fun, toast)) "duration" else "delay"
    expect_error(do.call(fxb_payload, c(list(fun = fun), setNames(list(complex(real = Inf)), arg))),
                 paste0("`", arg, "` must be a single finite"), fixed = TRUE)
  }
})

test_that("fx5 R3: custom themes remain available without attribute breakout", {
  for (theme in c("mytheme", "brand-blue", "brand_dark", "", "light", "dark")) {
    expect_identical(jsonlite::fromJSON(fxb_payload(toast, theme = theme))$theme, theme)
  }
  for (theme in list(NA_character_, c("light", "dark"), 1, TRUE,
                    "a b", "a\tb", "a\nb", "a\rb", "a\fb", "a\u00a0b",
                    'x" onclick="alert(1)', "x' onclick='alert(1)")) {
    expect_error(fxb_payload(toast, theme = theme), "`theme`", fixed = TRUE)
  }
  expect_null(jsonlite::fromJSON(fxb_payload(toast, theme = NULL))$theme)
})

test_that("fx5 R3: bundled toast layout 3 remains available", {
  for (layout in list(3, 3L, "3")) {
    expect_identical(jsonlite::fromJSON(fxb_payload(toast, layout = layout))$layout, 3L)
  }
})

test_that("fx5 R3: bundled revealIn and slideIn remain available", {
  for (transition in c("revealIn", "slideIn")) {
    expect_identical(jsonlite::fromJSON(fxb_payload(toast, transition_in = transition))$transitionIn,
                     transition)
  }
})

test_that("fx5 N2: every numeric zero message fails before Bootbox dispatch", {
  for (value in list(0, 0L, -0, c(zero = 0L), c(zero = 0))) {
    expect_error(fxb_payload(bootBox, message = value),
                 "`message` must be non-empty text or HTML.", fixed = TRUE)
  }
  expect_no_error(fxb_payload(bootBox, message = "0"))
  expect_no_error(fxb_payload(bootBox, message = 1L))
})

test_that("fx5 N3: validators return unnamed values and senders use them", {
  expect_identical(standby:::validate_choice(c(x = "growl"), "growl", "layout"), "growl")
  expect_identical(standby:::validate_flag(c(x = TRUE), "flag"), TRUE)
  expect_identical(standby:::validate_color(c(x = "red")), "red")
  expect_identical(standby:::normalize_delay(c(x = FALSE), "duration", false = TRUE), FALSE)
  expect_identical(standby:::normalize_css_length(c(x = "2em")), "2em")
})

test_that("fx5 N3: named sender arguments serialize as scalars", {
  specs <- list(
    list(alertify_alert, list(type = "warning", transition = "zoom", closable = FALSE)),
    list(alertify_notify, list(type = "message", position = "top-center", delay = 2)),
    list(bootBox, list(size = "large", backdrop = TRUE, show = FALSE, message = "hello")),
    list(tingle, list(button_type = "danger", button_position = "left", close_button = FALSE)),
    list(notify, list(type = "info", animation = "none", animate_speed = "fast",
                      icon = "custom", hide = FALSE, width = "50vw")),
    list(toast, list(type = "info", theme = "dark", position = "topRight", close = FALSE,
                     transition_in = "fadeIn", transition_out = "fadeOut", duration = FALSE)),
    list(notice, list(type = "success", layout = "growl", effect = "slide")),
    list(microTip, list(position = "bottom", size = "small"))
  )
  for (spec in specs) {
    args <- spec[[2]]
    named <- lapply(args, function(value) setNames(value, "label"))
    expect_identical(do.call(fxb_payload, c(list(fun = spec[[1]]), named)),
                     do.call(fxb_payload, c(list(fun = spec[[1]]), args)))
  }
  expect_match(fxb_payload(notice, layout = c(growl = "growl")),
               '"layout":"growl"', fixed = TRUE)
  # Cover every logical sender argument, not just one per sender.
  for (fun in list(alertify_alert, bootBox, tingle, notify, toast)) {
    flags <- names(Filter(is.logical, formals(fun)))
    for (arg in flags) {
      for (value in c(TRUE, FALSE)) {
        expect_identical(do.call(fxb_payload, c(list(fun = fun), setNames(list(c(label = value)), arg))),
                         do.call(fxb_payload, c(list(fun = fun), setNames(list(value), arg))))
      }
    }
  }
  expect_identical(fxb_payload(notify, icon = c(label = FALSE)), fxb_payload(notify, icon = FALSE))
  expect_identical(fxb_payload(bootBox, backdrop = c(label = FALSE)), fxb_payload(bootBox, backdrop = FALSE))
})

test_that("fx5 M2: vizLoad rejects missing label flags clearly", {
  x <- shiny::textOutput("x")
  for (value in list(NA, NULL, logical(), c(TRUE, FALSE), "yes")) {
    expect_error(vizLoad(x, add_label = value),
                 "`add_label` must be TRUE or FALSE.", fixed = TRUE)
  }
  expect_no_error(vizLoad(x, add_label = TRUE))
  expect_no_error(vizLoad(x, add_label = FALSE))
})

test_that("fx5 M-A: NEWS records the validation and default changes", {
  news <- paste(readLines(file.path(find.package("standby"), "NEWS.md"), warn = FALSE),
                collapse = " ")
  news <- sub("# standby 0.2.0.*", "", news)
  for (text in c("Eight message senders", "notice(effect = NULL)",
                 "toast(type = \"question\")", "backdrop = \"static\"",
                 "width = 500", "loaders(style =)", "strictly positive CSS length",
                 "toast(duration = Inf)", "alertify_notify(delay = Inf)",
                 "including `0L`", "discard scalar names", "vizLoad(add_label =)")) {
    expect_match(news, text, fixed = TRUE)
  }
})

test_that("fx5 docs: toast and Alertify document restored options", {
  pkg <- find.package("standby")
  db <- if (dir.exists(file.path(pkg, "man"))) tools::Rd_db(dir = pkg) else tools::Rd_db("standby")
  toast_help <- paste(unlist(db[["toast.Rd"]]), collapse = "")
  alert_help <- paste(unlist(db[["alertify.Rd"]]), collapse = "")
  for (text in c("Inf", "custom theme", "revealIn", "slideIn")) {
    expect_match(toast_help, text, fixed = TRUE)
  }
  expect_match(alert_help, "Inf", fixed = TRUE)
})
