#' @rdname alertify
#' @export 
useAlertify <- function() {
  htmltools::htmlDependency(
    name = "alertify",
    version = "0.1.0",
    src = c(file = "alertify"),
    script = list(list(src = "js/alertify.min.js", defer = NA), 
                  list(src = "js/sbyAlertify.js", defer = NA)),
    stylesheet = list("css/alertify.min.css",
                      "css/default.min.css",
                      "css/semantic.min.css",
                      "css/bootstrap.min.css"),
    package = "standby"
  )
}