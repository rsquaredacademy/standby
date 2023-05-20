#' @rdname spinkit
#' @export
#' 
useSpinkit <- function() {

  spin <- htmltools::htmlDependency(
    name = "spinkit",
    version = "0.1.0",
    src = c(file = 'spinkit'),
    stylesheet = "css/spinkit.min.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(spin, sby)
}
