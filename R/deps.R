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

#' @export
useSpinkit <- function() {

  htmltools::htmlDependency(
    name = "sby-spinkit",
    version = "0.1.0",
    src = "",
    stylesheet = "spinkit.min.css",
    package = "standby"
  )
}

#' @export
useVizLoad <- function() {

  htmltools::htmlDependency(
    name = "sby-vizload",
    version = "0.1.0",
    src = "",
    script = "ridics.js",
    stylesheet = "ridics.css",
    package = "standby"
  )
}

# useCssLoaders()
# useCssSpinners()
