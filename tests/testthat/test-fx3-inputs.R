test_that("fx3 N01: every SpinKit type receives the normalized size", {
  types <- c("plane", "chase", "bounce", "wave", "pulse", "flow", "swing",
             "circle", "circle-fade", "grid", "fold", "wander")
  sizes <- list(40, "40", "40px", "2.5em", "50%", ".5", 12.5)
  expected <- c("40px", "40px", "40px", "2.5em", "50%", ".5px", "12.5px")
  for (type in types) {
    for (i in seq_along(sizes)) {
      widget <- spinkit(shiny::div(), type = type, size = sizes[[i]])
      style <- paste(widget[[2]]$children[[1]]$attribs$style, collapse = " ")
      expect_match(style, paste0("width: ", expected[i], "; height: ", expected[i], ";"), fixed = TRUE)
      if (type == "wander") expect_match(style, paste0("--sk-size: ", expected[i], ";"), fixed = TRUE)
    }
    expect_identical(spinkit(shiny::div(), type = type)[[2]]$children[[1]]$attribs$style,
                     spinkit(shiny::div(), type = type, size = "40px")[[2]]$children[[1]]$attribs$style)
  }
  for (size in list("bogus", "40quux", "12.px", "40; color:red", "", NA, Inf,
                   NaN, TRUE, factor("40px"), character(), c(40, 50))) {
    expect_error(spinkit(shiny::div(), type = "wander", size = size), "Invalid `size`")
  }
  old <- options(OutDec = ",")
  on.exit(options(old))
  expect_match(as.character(spinkit(shiny::div(), type = "wander", size = 12.5)),
               "--sk-size: 12.5px;", fixed = TRUE)
})

test_that("fx3 N02: trailing decimal dots are rejected as malformed CSS numbers", {
  for (size in c("12.", "+2.", "1.")) {
    expect_error(normalize_css_length(size), "Invalid `length`")
    expect_error(spinkit(shiny::div(), size = size), "Invalid `size`")
    for (arg in c("title_size", "message_size", "title_line_height", "message_line_height", "image_width")) {
      expect_error(do.call(fxb_payload, c(list(fun = toast), setNames(list(size), arg))),
                   "Invalid `length`")
    }
  }
  for (size in c("12", "12.5", ".5", "12px")) {
    expected <- if (size == "12px") size else paste0(size, "px")
    expect_identical(normalize_css_length(size), expected)
    p <- jsonlite::fromJSON(fxb_payload(toast, title_size = size))
    expect_identical(p$titleSize, expected)
  }
  expect_identical(normalize_css_length(NULL), NULL)
  for (size in c("2.5em", "50%", "2rem", "10vw")) {
    expect_identical(normalize_css_length(size), size)
  }
})
