#' @rdname notice
#' @export
useNS <- function() {

  htmltools::htmlDependency(
    name = "ns",
    version = "0.1.0",
    src = c(file = "ns"),
    script = list(list(src = "js/modernizr.custom.js", defer = NA),
                  list(src = "js/classie.js", defer = NA),
                  list(src = "js/notificationFx.js", defer = NA),
                  list(src = "js/ns.js", defer = NA)),
    stylesheet = list("css/normalize.css",
                      "css/ns-default.css",
                      "css/ns-style-growl.css",
                      "css/ns-style-attached.css",
                      "css/ns-style-bar.css"),
    package = "standby"
  )
}