#' @export  
standby <- function() {

  htmltools::htmlDependency(
    name = "sby-css",
    version = "0.1.0",
    src = "",
    script = list(src = "script.js", defer = NA),
    stylesheet = "style.css",
    package = "standby"
  )

}

#' @export
useThreeDots <- function() {

  dots <- htmltools::htmlDependency(
    name = "sby-pkg",
    version = "0.1.0",
    src = "",
    stylesheet = "three-dots.css",
    package = "standby"
  )

  sby <- standby()

  htmltools::tagList(dots, sby)

}

#' @export
useSpinkit <- function() {

  spin <- htmltools::htmlDependency(
    name = "sby-spinkit",
    version = "0.1.0",
    src = "",
    stylesheet = "spinkit.min.css",
    package = "standby"
  )

  sby <- standby()

  htmltools::tagList(spin, sby)
}

#' @export
useVizLoad <- function() {

  viz <- htmltools::htmlDependency(
    name = "sby-vizload",
    version = "0.1.0",
    src = "",
    script = "ridics.js",
    stylesheet = "ridics.css",
    package = "standby"
  )

  sby <- standby()

  htmltools::tagList(viz, sby)
}

#' @export
useSpinners <- function() {

  spinner <- htmltools::htmlDependency(
    name = "sby-spinners",
    version = "0.1.0",
    src = "",
    stylesheet = "spinners.css",
    package = "standby"
  )

  sby <- standby()

  htmltools::tagList(spinner, sby)
}

#' @export
useLoaders <- function() {

  loader <- htmltools::htmlDependency(
    name = "sby-loaders",
    version = "0.1.0",
    src = "",
    stylesheet = "loaders.css",
    package = "standby"
  )

  sby <- standby()

  htmltools::tagList(loader, sby)
}
