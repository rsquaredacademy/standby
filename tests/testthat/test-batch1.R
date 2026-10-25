payload <- "red</style><script>alert(1)</script><style>"

test_that("N1: color injection payload errors for every loader", {
  expect_error(
    threeDots(shiny::div("test"), color = payload),
    "Invalid `color`"
  )
  expect_error(
    spinkit(shiny::div("test"), type = "chase", color = payload),
    "Invalid `color`"
  )
  expect_error(
    spinners(shiny::div("test"), type = 1, color = payload),
    "Invalid `color`"
  )
  expect_error(
    vizLoad(shiny::div("test"), type = "circles", color = payload),
    "Invalid `color`"
  )
})

test_that("N1: vizLoad validates type against documented types", {
  expect_error(
    vizLoad(shiny::div("test"), type = payload, add_label = TRUE),
    "should be one of"
  )
  expect_error(
    vizLoad(shiny::div("test"), type = "bogus"),
    "should be one of"
  )
})

test_that("N1: valid colors render properly across formats", {
  valid_colors <- c(
    "red", "blue", "aliceblue",
    "#fff", "#123456", "#12345678",
    "rgb(255, 0, 0)", "rgba(255, 0, 0, 0.5)",
    "rgba(255, 0, 0, .5)", "rgba(0,0,0,.5)",
    "hsl(120, 100%, 50%)", "hsla(120, 100%, 50%, 0.8)",
    "hsla(120,100%,50%,.8)",
    "transparent", "currentColor"
  )

  for (col in valid_colors) {
    expect_no_error(threeDots(shiny::div("test"), color = col))
    expect_no_error(spinkit(shiny::div("test"), type = "chase", color = col))
    expect_no_error(spinners(shiny::div("test"), type = 1, color = col))
    expect_no_error(vizLoad(shiny::div("test"), type = "circles", color = col))
  }
})

test_that("N1: invalid colors with dangerous characters are rejected", {
  invalid_colors <- c(
    "red; background: blue",
    "red</style>",
    "<script>",
    "red{color:blue}",
    "rgb(1, 2, 3; evil)",
    "rgb(1, 2, 3) </style>",
    "blue\"",
    "blue'",
    ";"
  )

  for (inv in invalid_colors) {
    expect_error(validate_color(inv, "color"), "Invalid `color`")
  }
})

test_that("N2: spinners generated CSS is scoped per instance", {
  s1 <- spinners(shiny::div("first"), type = 1, color = "red")
  s2 <- spinners(shiny::div("second"), type = 1, color = "blue")

  rt1 <- htmltools::renderTags(s1)
  rt2 <- htmltools::renderTags(s2)

  head1 <- as.character(rt1$head)
  head2 <- as.character(rt2$head)

  # Extract IDs from styles
  id1 <- sub(".*#([a-zA-Z0-9_-]+) \\.load1.*", "\\1", head1)
  id2 <- sub(".*#([a-zA-Z0-9_-]+) \\.load1.*", "\\1", head2)

  expect_true(nchar(id1) > 0)
  expect_true(nchar(id2) > 0)
  expect_false(id1 == id2)

  # Check colours in each head style
  expect_match(head1, paste0("#", id1, " \\.load1.*color: red;"))
  expect_match(head2, paste0("#", id2, " \\.load1.*color: blue;"))

  # Check HTML container has matching id
  expect_match(as.character(rt1$html), paste0('id="', id1, '"'))
  expect_match(as.character(rt2$html), paste0('id="', id2, '"'))
})

test_that("N2: spinners type 5 keyframes are scoped per instance", {
  s1 <- spinners(shiny::div("first"), type = 5, color = "red")
  s2 <- spinners(shiny::div("second"), type = 5, color = "blue")

  rt1 <- htmltools::renderTags(s1)
  rt2 <- htmltools::renderTags(s2)

  head1 <- as.character(rt1$head)
  head2 <- as.character(rt2$head)

  # Extract IDs from the scoped rule
  id1 <- sub(".*#([a-zA-Z0-9_-]+) \\.load5.*", "\\1", head1)
  id2 <- sub(".*#([a-zA-Z0-9_-]+) \\.load5.*", "\\1", head2)

  expect_true(nchar(id1) > 0)
  expect_true(nchar(id2) > 0)
  expect_false(id1 == id2)

  # Keyframe names are unique per instance
  expect_match(head1, paste0("@-webkit-keyframes load5-", id1, " \\{"))
  expect_match(head1, paste0("@keyframes load5-", id1, " \\{"))
  expect_match(head2, paste0("@-webkit-keyframes load5-", id2, " \\{"))
  expect_match(head2, paste0("@keyframes load5-", id2, " \\{"))

  # Each instance binds its own keyframes under its scoped selector
  expect_match(
    head1,
    paste0("#", id1, " \\.load5 \\.loader \\{ -webkit-animation: load5-", id1,
           " 1\\.1s infinite ease; animation: load5-", id1, " 1\\.1s infinite ease; \\}")
  )
  expect_match(
    head2,
    paste0("#", id2, " \\.load5 \\.loader \\{ -webkit-animation: load5-", id2,
           " 1\\.1s infinite ease; animation: load5-", id2, " 1\\.1s infinite ease; \\}")
  )

  # Each instance keeps its own colour
  expect_match(head1, "box-shadow: 0em -2.6em 0em 0em red")
  expect_match(head2, "box-shadow: 0em -2.6em 0em 0em blue")
  expect_false(grepl("blue", head1, fixed = TRUE))
  expect_false(grepl("red", head2, fixed = TRUE))

  expect_match(as.character(rt1$html), paste0('id="', id1, '"'))
  expect_match(as.character(rt2$html), paste0('id="', id2, '"'))
})

test_that("N2: vizLoad circles CSS is scoped per instance", {
  v1 <- vizLoad(shiny::div("first"), type = "circles", color = "red")
  v2 <- vizLoad(shiny::div("second"), type = "circles", color = "blue")

  rt1 <- htmltools::renderTags(v1)
  rt2 <- htmltools::renderTags(v2)

  head1 <- as.character(rt1$head)
  head2 <- as.character(rt2$head)

  id1 <- sub(".*#([a-zA-Z0-9_-]+) \\.lv-circles.*", "\\1", head1)
  id2 <- sub(".*#([a-zA-Z0-9_-]+) \\.lv-circles.*", "\\1", head2)

  expect_true(nchar(id1) > 0)
  expect_true(nchar(id2) > 0)
  expect_false(id1 == id2)

  expect_match(head1, paste0("#", id1, " \\.lv-circles.*background-color: red;"))
  expect_match(head2, paste0("#", id2, " \\.lv-circles.*background-color: blue;"))

  expect_match(as.character(rt1$html), paste0('id="', id1, '"'))
  expect_match(as.character(rt2$html), paste0('id="', id2, '"'))
})

test_that("N2: vizLoad label CSS is scoped per instance", {
  vl1 <- vizLoad(shiny::div("first"), type = "bars", add_label = TRUE, color = "red")
  vl2 <- vizLoad(shiny::div("second"), type = "bars", add_label = TRUE, color = "blue")

  rt1 <- htmltools::renderTags(vl1)
  rt2 <- htmltools::renderTags(vl2)

  head1 <- as.character(rt1$head)
  head2 <- as.character(rt2$head)

  id1 <- sub(".*#([a-zA-Z0-9_-]+) \\.lv-bars.*", "\\1", head1)
  id2 <- sub(".*#([a-zA-Z0-9_-]+) \\.lv-bars.*", "\\1", head2)

  expect_true(nchar(id1) > 0)
  expect_true(nchar(id2) > 0)
  expect_false(id1 == id2)

  expect_match(head1, paste0("#", id1, " \\.lv-bars\\[data-label\\]:after \\{ color: red;\\}"))
  expect_match(head2, paste0("#", id2, " \\.lv-bars\\[data-label\\]:after \\{ color: blue;\\}"))

  expect_match(as.character(rt1$html), paste0('id="', id1, '"'))
  expect_match(as.character(rt2$html), paste0('id="', id2, '"'))
})

test_that("N3: alertify_alert formals match documented defaults", {
  f <- formals(alertify_alert)
  expect_identical(f$auto_reset, FALSE)
  expect_identical(f$maximizable, FALSE)
  expect_identical(f$modal, FALSE)
  expect_identical(f$movable, FALSE)
  expect_identical(f$move_bounded, TRUE)
  expect_identical(f$overflow, FALSE)
})
