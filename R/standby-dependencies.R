#' standby dependencies
#' 
#' @description Attaches custom script and stylesheet.
#' @keywords internal
#' 
standbyDeps <- function() {

  htmltools::htmlDependency(
    name = "standby",
    version = "0.2.2",
    src = c(file = 'standby'),
    script = list(src = "js/standby.js", defer = NA),
    stylesheet = "css/standby.css",
    package = "standby"
  )

}