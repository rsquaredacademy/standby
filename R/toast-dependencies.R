#' @rdname toast
#' @export
useToast <- function() {

  htmltools::htmlDependency(
    name = "toast",
    version = "0.1.0",
    src = c(file = "toast"),
    script = list(list(src = "js/iziToast.min.js", defer = NA),
                  list(src = "js/sbyToast.js", defer = NA)),
    stylesheet = "css/iziToast.min.css",
    package = "standby"
  )

}