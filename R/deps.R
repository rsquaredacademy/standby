#' @export
useThreeDots <- function() {

  pkg <- htmltools::htmlDependency(
    name = "sby-pkg",
    version = "0.1.0",
    src = "",
    script = list(src = "script.js", defer = NA),
    stylesheet = "three-dots.css",
    package = "standby"
  )

  sby_style <- htmltools::htmlDependency(
    name = "sby-css",
    version = "0.1.0",
    src = "",
    stylesheet = "style.css",
    package = "standby"
  )

  htmltools::tagList(pkg, sby_style)

}

# useThreeDots()
# useSpinKit()
# useCssLoaders()
# useCssSpinners()