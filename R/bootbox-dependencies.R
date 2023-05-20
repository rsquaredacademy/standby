#' @rdname bootBox
#' @export 
useBootBox <- function() {
  
  boot <- htmltools::htmlDependency(
    name = "bootbox",
    version = "0.1.0",
    src = c(file = "bootbox"),
    script = list(list(src = "js/bootbox.all.min.js", defer = NA),
                  list(src = "js/sbyBootbox.js", defer = NA)), 
    stylesheet = "css/animate.min.css",
    package = "standby"
  )
  
  sby <- standbyDeps()

  htmltools::tagList(boot, sby)
}