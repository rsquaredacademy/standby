#' @rdname spinners
#' @export
#' 
useSpinners <- function() {

  spinner <- htmltools::htmlDependency(
    name = "spinners",
    version = "0.1.0",
    src = c(file = "spinners"),
    stylesheet = "css/spinners.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(spinner, sby)
}