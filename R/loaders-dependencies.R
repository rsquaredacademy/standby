#' @rdname loaders
#' @export
#' 
useLoaders <- function() {

  loader <- htmltools::htmlDependency(
    name = "loaders",
    version = "0.2.2",
    src = c(file = "loaders"),
    stylesheet = "css/loaders.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(loader, sby)
}