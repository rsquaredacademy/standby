#' @rdname spinners
#' @export
#' 
useSpinners <- function() {

  spinner <- htmltools::htmlDependency(
    name = "spinners",
    version = "0.2.2",
    src = c(file = "spinners"),
    stylesheet = "css/spinners.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(spinner, sby)
}