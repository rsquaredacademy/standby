#' @rdname vizLoad
#' @export
#' 
useVizLoad <- function() {

  viz <- htmltools::htmlDependency(
    name = "vizload",
    version = "0.1.0",
    src = c(file = "vizload"),
    script = "js/ridics.js",
    stylesheet = "css/ridics.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(viz, sby)
}