#' @rdname bootBox
#' @export 
useBootBox <- function() {
  
  boot <- htmltools::htmlDependency(
    name = "bootbox",
    version = "0.1.0",
    src = c(file = "bootbox"),
    script = list(list(src = "js/bootbox.all.min.js", defer = NA),
                  list(src = "js/sbyBootbox.js", defer = NA)), 
    stylesheet = c("css/animate.min.css", "css/sbyBootbox.css"),
    package = "standby"
  )
  
  sby <- standbyDeps()

  htmltools::tagList(boot, sby)
}
