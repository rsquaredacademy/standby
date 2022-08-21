#' Include Dependencies
#' 
#' Dependencies for spinners/loaders. Include anywhere in the UI of the app.
#' 
#' @section Functions:
#' \itemize{
#' \item {useThreeDots}: Include dependencies for <https://github.com/nzbin/three-dots>
#' \item {useSpinKit}: Include dependencies for <https://github.com/tobiasahlin/SpinKit>
#' \item {useVizLoad}: Include dependencies for <https://github.com/RIDICS/Loading-Visualization>
#' \item {useSpinners}: Include dependencies for <https://github.com/lukehaas/css-loaders> 
#' \item {useLoaders}: Include dependencies for <https://github.com/raphaelfabeni/css-loader>
#' }
#' 
#' @name standbyDeps
#' @export 
#' 
NULL

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

#' @rdname standbyDeps
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

#' @rdname standbyDeps
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

#' @rdname standbyDeps
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

#' @rdname standbyDeps
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

#' @rdname standbyDeps
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
