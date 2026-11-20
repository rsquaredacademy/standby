#' @rdname notify
#' @export
useNotify <- function() {

  htmltools::htmlDependency(
    name = "pnotify",
    version = "0.2.2",
    src = c(file = "pnotify"),
    script = list(list(src = "js/PNotify.js", defer = NA), 
                  list(src = "js/notify.js", defer = NA)),
    stylesheet = list("css/PNotify.css",
                      "css/BrightTheme.css",
                      "css/sbyNotify.css"),
    package = "standby"
  )
}