#' @rdname microTip
#' @export 
useMicroTip <- function() {
  
  mtip <- htmltools::htmlDependency(
    name = "microtip",
    version = "0.1.0",
    src = c(file = "microtip"),
    script = "js/microtip.js",
    stylesheet = "css/microtip.min.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(mtip, sby)
}