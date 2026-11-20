# Run from the package root: Rscript docs-dev/pkg-standby-fx6-render.R before
# or Rscript docs-dev/pkg-standby-fx6-render.R after
Sys.setenv(NOT_CRAN = "true")
stage <- commandArgs(TRUE)[1]
if (is.na(stage)) stage <- "after"
if (stage == "before") {
  # Read the original commit in an isolated temporary directory; keep this
  # worktree and branch in place. Current gate code exercises both revisions.
  archive <- tempfile(fileext = ".zip")
  baseline <- tempfile(pattern = "standby-fx6-before-")
  dir.create(baseline)
  status <- system2("git", c("archive", "--format=zip",
    paste0("--output=", shQuote(archive)), "aa38d8b"))
  if (status != 0) stop("Could not archive baseline")
  utils::unzip(archive, exdir = baseline)
  pkgload::load_all(baseline)
} else pkgload::load_all(".")
source("tests/testthat/helper-browser.R")
source("tests/testthat/helper-render-gate.R")
cases <- fx6_cases()
cases[["H3 half + text"]] <- list(family = "loaders",
  args = list(type = "default", style = "half", text = "Loading..."))
cases[["H3 double + blink"]] <- list(family = "loaders",
  args = list(type = "double", style = "blink"))
for (type in c("swing", "wander")) {
  cases[[paste("H4 alpha", type)]] <- list(family = "spinkit",
    args = list(type = type, color = "rgba(255,0,0,0.4)"))
}
options_sheet <- identical(commandArgs(TRUE)[2], "options")
if (options_sheet) {
  cases <- list()
  styles <- list(half = "default", inverse = c("default", "bar"),
    rounded = c("bar", "bar-ping-pong"), blink = c("default", "bar", "border"))
  for (style in names(styles)) for (type in styles[[style]]) {
    texts <- if (type == "bar-ping-pong") list(NULL) else list(NULL, "Loading...")
    for (text in texts) cases[[paste("loaders", type, style, if (is.null(text)) "" else "text")]] <-
      list(family = "loaders", args = list(type = type, style = style, text = text))
  }
  for (type in c("curtain", "smartphone")) cases[[paste(type, "text")]] <-
    list(family = "loaders", args = list(type = type, text = "Loading..."))
  for (type in fx6_types$spinkit) for (size in c("24px", "64px")) cases[[paste("spinkit", type, size)]] <-
    list(family = "spinkit", args = list(type = type, size = size))
  for (type in fx6_types$vizLoad) {
    sizes <- if (type %in% c("line", "bordered_line")) c("fluid", "medium", "small") else c("medium", "small", "tiny")
    for (size in sizes) cases[[paste("vizLoad", type, size)]] <-
      list(family = "vizLoad", args = list(type = type, size = size))
  }
}
cards <- lapply(seq_along(cases), function(i) {
  page <- tryCatch(fx6_page(cases[[i]]), error = function(e) paste0(
    "<body style='background:#fff;font:16px sans-serif;padding:20px'>",
    htmltools::htmlEscape(conditionMessage(e)), "</body>"))
  shiny::tags$div(class = "card", shiny::tags$div(class = "label", names(cases)[i]),
    shiny::tags$iframe(srcdoc = page, width = 360, height = 320))
})
page <- fxb_page(body = as.character(htmltools::tagList(cards)), head = paste0(
  "<style>body{display:grid;grid-template-columns:repeat(4,360px);gap:8px;background:#ddd;",
  "padding:8px;font:16px sans-serif}.card{background:white}.label{height:28px;line-height:28px;",
  "padding-left:8px}iframe{border:0;display:block}</style>"))
s <- fxb_open(page)
s$Emulation$setDeviceMetricsOverride(width = 1480L, height = as.integer(8 + ceiling(length(cases) / 4) * 356),
  deviceScaleFactor = 1, mobile = FALSE)
fxb_wait(s, 1500)
fxb_eval(s, "(function(){document.querySelectorAll('iframe').forEach(function(f){
  var d=f.contentDocument, time=d.querySelector('.dot-pulse')?400:
    d.querySelector('.sk-pulse')?600:d.querySelector('.lv-dots')?650:1273;
  f.contentDocument.getAnimations().forEach(function(a){a.pause();
  a.currentTime=time;});});return true;})()")
fxb_wait(s, 150)
path <- if (options_sheet) "docs-dev/pkg-standby-fx6-options.png" else if (stage == "before")
  "docs-dev/pkg-standby-fx6-before.png" else "docs-dev/pkg-standby-fx6-types.png"
writeBin(jsonlite::base64_dec(s$Page$captureScreenshot(format = "png", captureBeyondViewport = TRUE)$data), path)
if (!options_sheet) {
  clips <- list(h1 = list(x=8,y=8,width=1464,height=1772,scale=1),
    h2 = list(x=1112,y=2500,width=360,height=348,scale=1),
    h3 = list(x=8,y=5348,width=728,height=348,scale=1),
    h4 = list(x=744,y=5348,width=728,height=348,scale=1))
  for (finding in names(clips)) {
    data <- s$Page$captureScreenshot(format = "png", clip = clips[[finding]])$data
    writeBin(jsonlite::base64_dec(data), paste0("docs-dev/pkg-standby-fx6-", finding, "-", stage, ".png"))
  }
}
s$close()
if (!options_sheet) {
  preview <- htmltools::renderTags(htmltools::tagList(useSpinkit(),
    get("glanceSpinkit", asNamespace("standby"))()))
  preview_css <- unlist(lapply(preview$dependencies,
    function(d) file.path(d$src$file, d$stylesheet)), use.names = FALSE)
  p <- fxb_open(fxb_page(body = preview$html, head = paste0(preview$head,
    "<style>body{background:black}.standby{height:320px}</style>"), css = preview_css))
  p$Emulation$setDeviceMetricsOverride(width = 360L, height = 320L,
    deviceScaleFactor = 1, mobile = FALSE)
  fx6_phase(p, 1.2)
  writeBin(jsonlite::base64_dec(fx6_capture(p)), paste0("docs-dev/pkg-standby-fx6-l1-", stage, ".png"))
  p$close()
}
cat("Saved", path, "with", length(cases), "cases\n")
