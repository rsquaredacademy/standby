test_that("fx3 N01: wander numeric sizes have their requested width and quarter-cycle travel", {
  fxb_available()
  sizes <- list(40, "40", "40px", "2.5em")
  widgets <- lapply(sizes, function(size) fxb_render(spinkit(shiny::div(), type = "wander", size = size)))
  widgets[[5]] <- fxb_render(spinkit(shiny::div(), type = "wander"))
  s <- fxb_open(fxb_page(
    body = paste(vapply(widgets, `[[`, "", "html"), collapse = ""),
    head = "<style>body{font-size:16px}</style>",
    css = fxb_file("spinkit/css/spinkit.min.css")))
  on.exit(s$close())
  s$Emulation$setDeviceMetricsOverride(width = 992, height = 800, deviceScaleFactor = 1, mobile = FALSE)
  state <- fxb_eval(s, "Array.from(document.querySelectorAll('.sk-wander')).map(e => {
    const c=e.firstElementChild, a=c.getAnimations()[0];
    a.pause(); a.currentTime=a.effect.getTiming().duration/4;
    return {width:parseFloat(getComputedStyle(e).width),
      travel:new DOMMatrix(getComputedStyle(c).transform).m41,
      size:e.style.getPropertyValue('--sk-size').trim()};
  })")
  expect_length(state, 5)
  for (i in seq_along(state)) {
    expect_equal(state[[i]]$width, 40, tolerance = .001)
    expect_equal(state[[i]]$travel, 30, tolerance = .001)
    expect_equal(state[[i]]$travel, state[[i]]$width * .75, tolerance = .001)
    expect_identical(state[[i]]$size, if (i == 4) "2.5em" else "40px")
  }
})

test_that("fx3 N01: all SpinKit types compute numeric and relative widths consistently", {
  fxb_available()
  types <- c("plane", "chase", "bounce", "wave", "pulse", "flow", "swing",
             "circle", "circle-fade", "grid", "fold", "wander")
  sizes <- list(40, "40", "40px", "2.5em", "50%")
  widgets <- unlist(lapply(types, function(type) lapply(sizes, function(size) {
    fxb_render(spinkit(shiny::div(), type = type, size = size))$html
  })), use.names = FALSE)
  s <- fxb_open(fxb_page(body = paste(widgets, collapse = ""),
    head = "<style>body{font-size:16px}.standby{width:200px;height:200px}</style>",
    css = fxb_file("spinkit/css/spinkit.min.css")))
  on.exit(s$close())
  state <- fxb_eval(s, "Array.from(document.querySelectorAll('.standby-wait')).map(e => ({
    width:parseFloat(getComputedStyle(e).width),height:parseFloat(getComputedStyle(e).height)
  }))")
  expect_length(state, length(types) * length(sizes))
  expected <- rep(c(40, 40, 40, 40, 100), length(types))
  for (i in seq_along(state)) {
    expect_equal(state[[i]]$width, expected[i], tolerance = .001)
    expect_equal(state[[i]]$height, expected[i], tolerance = .001)
  }
})
