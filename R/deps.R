standbyDeps <- function() {

  htmltools::htmlDependency(
    name = "sby-css",
    version = "0.1.0",
    src = "",
    script = list(src = "script.js", defer = NA),
    stylesheet = "style.css",
    package = "standby"
  )

}

#' @rdname threeDots
#' @export
#' 
useThreeDots <- function() {

  dots <- htmltools::htmlDependency(
    name = "sby-pkg",
    version = "0.1.0",
    src = "",
    stylesheet = "three-dots.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(dots, sby)

}

#' @rdname spinkit
#' @export
#' 
useSpinkit <- function() {

  spin <- htmltools::htmlDependency(
    name = "sby-spinkit",
    version = "0.1.0",
    src = "",
    stylesheet = "spinkit.min.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(spin, sby)
}

#' @rdname vizLoad
#' @export
#' 
useVizLoad <- function() {

  viz <- htmltools::htmlDependency(
    name = "sby-vizload",
    version = "0.1.0",
    src = "",
    script = "ridics.js",
    stylesheet = "ridics.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(viz, sby)
}

#' @rdname spinners
#' @export
#' 
useSpinners <- function() {

  spinner <- htmltools::htmlDependency(
    name = "sby-spinners",
    version = "0.1.0",
    src = "",
    stylesheet = "spinners.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(spinner, sby)
}

#' @rdname loaders
#' @export
#' 
useLoaders <- function() {

  loader <- htmltools::htmlDependency(
    name = "sby-loaders",
    version = "0.1.0",
    src = "",
    stylesheet = "loaders.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(loader, sby)
}
