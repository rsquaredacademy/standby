test_that("rx5 R4/L-1: FALSE, NA and +/-Inf delays keep notifications open", {
  s <- shiny::MockShinySession$new()
  last <- NULL
  s$sendCustomMessage <- function(type, message) last <<- message
  for (v in list(FALSE, NA, NaN, NA_character_, -Inf, Inf, NULL)) {
    alertify_notify(delay = v, session = s)
    expect_identical(last$delay, 0)
  }
  for (v in list(FALSE, NA, NaN, NA_character_, -Inf, Inf)) {
    toast("a", "b", duration = v, session = s)
    expect_false(last$timeout)
  }
  alertify_notify(delay = 3000, session = s)
  expect_identical(last$delay, 3000)
  expect_error(alertify_notify(delay = "abc", session = s), "delay")
})
