#' @rdname threeDots
#' @export
#' 
useThreeDots <- function() {

  dots <- htmltools::htmlDependency(
    name = "three-dots",
    version = "0.2.2",
    src = c(file = 'three-dots'),
    stylesheet = "css/three-dots.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(dots, sby)

}