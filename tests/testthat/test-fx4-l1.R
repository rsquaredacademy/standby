test_that("fx4 L1: notice defaults and explicit effects match each layout", {
  effects <- list(growl = c("jelly", "scale", "slide", "genie"),
                  attached = c("flip", "bouncyflip"), bar = c("slidetop", "exploader"))
  for (layout in names(effects)) {
    for (args in list(list(layout = layout), list(layout = layout, effect = NULL))) {
      p <- jsonlite::fromJSON(do.call(fxb_payload, c(list(fun = notice), args)))
      expect_identical(p$effect, effects[[layout]][1])
      expect_identical(p$layout, layout)
    }
    for (effect in effects[[layout]]) {
      p <- jsonlite::fromJSON(fxb_payload(notice, layout = layout, effect = effect))
      expect_identical(p$effect, effect)
    }
    invalid <- setdiff(unlist(effects), effects[[layout]])
    for (effect in invalid) {
      expect_error(fxb_payload(notice, layout = layout, effect = effect),
                   paste0("`effect` must be one of: ", paste(effects[[layout]], collapse = ", ")),
                   fixed = TRUE)
    }
  }
})

test_that("fx4 L1: each default notice has a bundled animation in Chrome", {
  fxb_available()
  scripts <- c(fxb_file("ns/js/modernizr.custom.js"), fxb_file("ns/js/classie.js"),
               fxb_file("ns/js/notificationFx.js"), fxb_file("ns/js/ns.js"))
  # useNS() defers these scripts; NotificationFx captures document.body on load.
  body <- paste0("<script>", paste(vapply(scripts, fxb_read, ""), collapse = "\n"), "</script>")
  s <- fxb_open(fxb_page(
    body = body,
    css = c(fxb_file("ns/css/ns-default.css"), fxb_file("ns/css/ns-style-growl.css"),
            fxb_file("ns/css/ns-style-attached.css"), fxb_file("ns/css/ns-style-bar.css"))))
  on.exit(s$close())
  for (layout in c("growl", "attached", "bar")) {
    p <- fxb_payload(notice, layout = layout)
    fxb_eval(s, paste0("Shiny.handlers['ns.send'](", p, ");"))
    animation <- fxb_eval(s, sprintf("getComputedStyle(document.querySelector('.ns-%s')).animationName", layout))
    expect_false(animation %in% c("none", ""))
  }
})
