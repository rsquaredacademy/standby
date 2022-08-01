#' export
use_three <- function() {

  pkg <- htmltools::htmlDependency(
    name = "sby-pkg",
    version = "1.0.0",
    src = "",
    script = "script.js",
    stylesheet = "three-dots.css",
    package = "standby"
  )

  sby_style <- htmltools::htmlDependency(
    name = "sby-css",
    version = "1.0.0",
    src = "",
    stylesheet = "style.css",
    package = "standby"
  )

  htmltools::tagList(pkg, sby_style)

}