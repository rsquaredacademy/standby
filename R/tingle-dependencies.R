#' @rdname tingle
#' @export 
useTingle <- function() {
  htmltools::htmlDependency(
    name = "tingle",
    version = "0.1.0",
    src = c(file = "tingle"),
    script = list(list(src = "js/tingle.min.js", defer = NA), 
                  list(src = "js/sbyTingle.js", defer = NA)),
    stylesheet = "css/tingle.min.css",
    package = "standby"
  ) 
}