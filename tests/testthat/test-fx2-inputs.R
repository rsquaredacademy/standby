test_that("fx2 M02: malformed CSS colours are rejected completely", {
  invalid <- c("rgb(255,0,0,)", "rgb(100%,0,0)", "rgb(255 0 0 /)",
               "rgba(255,0,0,.5,)", "rgb(255 0 0 / 50%/)",
               "hsl(0,100%,50%,)", "rgb(1.,0,0)", "hsl(1.,100%,50%)",
               "rgb(1,,2)", "rgba(1 2 3 // .5)")
  for (fun in list(spinners, spinkit, threeDots, vizLoad)) {
    for (color in invalid) expect_error(fun(shiny::div(), color = color), "Invalid `color`")
    for (color in c("red", "#f00", "#f008", "#ff0000", "#ff000080",
                    "rgb(255,0,0)", "rgba(255,0,0,.5)", "hsl(-120deg 100% 50% / 50%)",
                    "rgb(100% 0 0 / .5)", "transparent")) {
      expect_no_error(fun(shiny::div(), color = color))
    }
  }
})

test_that("fx2 M05: SpinKit rejects invalid scalar types", {
  for (type in list("bogus", NA_character_, factor("wander"), NULL, character(),
                   c("plane", "wander"), 1, TRUE)) {
    expect_error(spinkit(shiny::div(), type = type), "`type`")
  }
  for (type in c("plane", "chase", "bounce", "wave", "pulse", "flow", "swing",
                 "circle", "circle-fade", "grid", "fold", "wander")) {
    html <- as.character(htmltools::renderTags(spinkit(shiny::div(), type = type))$html)
    expect_match(html, paste0("sk-", type), fixed = TRUE)
    expect_match(html, "standby-wait", fixed = TRUE)
  }
})

test_that("fx2 M08: CSS numbers ignore OutDec", {
  old <- options(OutDec = ",")
  on.exit(options(old))
  for (size in c(12.5, .5)) {
    p <- jsonlite::fromJSON(fxb_payload(toast, title_size = size,
      message_size = 18.5, image_width = size, duration = FALSE))
    expect_identical(p$titleSize, paste0(format(size, decimal.mark = "."), "px"))
    expect_identical(p$messageSize, "18.5px")
    expect_identical(p$imageWidth, p$titleSize)
  }
})

test_that("fx2 L02: toast display modes require exact integers", {
  for (mode in c("0.9", "1.9", "2.9", "-0.9", "1.0", "1e0", "", "NA")) {
    expect_error(toast(display_mode = mode, session = list()), "display_mode")
  }
  for (mode in list(0, 1, 2, "0", "1", "2", " 1 ")) {
    expect_no_error(fxb_payload(toast, display_mode = mode))
  }
})

test_that("fx2 L03: shared help describes actual dependency returns", {
  topics <- c("alertify", "bootBox", "microTip", "notice", "notify", "tingle", "toast")
  for (topic in topics) {
    path <- test_path("..", "..", "man", paste0(topic, ".Rd"))
    rd <- if (file.exists(path)) tools::parse_Rd(path) else tools::Rd_db("standby")[[paste0(topic, ".Rd")]]
    value <- Filter(function(x) identical(attr(x, "Rd_tag"), "\\value"), rd)
    text <- paste(unlist(value), collapse = " ")
    expect_match(text, if (topic %in% c("bootBox", "microTip")) "tag list" else "dependency")
    expect_match(text, "side effect")
    expect_false(grepl("None", text, fixed = TRUE))
  }
  for (fun in list(useAlertify, useNS, useNotify, useTingle, useToast)) {
    expect_s3_class(fun(), "html_dependency")
  }
  for (fun in list(useBootBox, useMicroTip, useLoaders, useSpinkit, useSpinners,
                   useThreeDots, useVizLoad)) {
    expect_s3_class(fun(), "shiny.tag.list")
    expect_true(all(vapply(fun(), inherits, logical(1), "html_dependency")))
  }
  expect_s3_class(loaders(shiny::div()), "shiny.tag")
})
