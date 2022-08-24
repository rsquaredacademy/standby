standbyDeps <- function() {

  htmltools::htmlDependency(
    name = "sby-css",
    version = "0.1.0",
    src = "",
    script = list(src = "script.js", defer = NA),
    stylesheet = "style.css",
    package = "standby"
  )

}

#' @rdname threeDots
#' @export
#' 
useThreeDots <- function() {

  dots <- htmltools::htmlDependency(
    name = "sby-pkg",
    version = "0.1.0",
    src = "",
    stylesheet = "three-dots.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(dots, sby)

}

#' @rdname spinkit
#' @export
#' 
useSpinkit <- function() {

  spin <- htmltools::htmlDependency(
    name = "sby-spinkit",
    version = "0.1.0",
    src = "",
    stylesheet = "spinkit.min.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(spin, sby)
}

#' @rdname vizLoad
#' @export
#' 
useVizLoad <- function() {

  viz <- htmltools::htmlDependency(
    name = "sby-vizload",
    version = "0.1.0",
    src = "",
    script = "ridics.js",
    stylesheet = "ridics.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(viz, sby)
}

#' @rdname spinners
#' @export
#' 
useSpinners <- function() {

  spinner <- htmltools::htmlDependency(
    name = "sby-spinners",
    version = "0.1.0",
    src = "",
    stylesheet = "spinners.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(spinner, sby)
}

#' @rdname loaders
#' @export
#' 
useLoaders <- function() {

  loader <- htmltools::htmlDependency(
    name = "sby-loaders",
    version = "0.1.0",
    src = "",
    stylesheet = "loaders.css",
    package = "standby"
  )

  sby <- standbyDeps()

  htmltools::tagList(loader, sby)
}

#' @rdname toast
#' @export
useToast <- function() {

  htmltools::htmlDependency(
    name = "sby-toast",
    version = "0.1.0",
    src = "",
    script = list(list(src = "iziToast.min.js", defer = NA),
                  list(src = "buzz.js", defer = NA)),
    stylesheet = "iziToast.min.css",
    package = "standby"
  )

}

#' @rdname notice
#' @export
useNS <- function() {

  htmltools::htmlDependency(
    name = "sby-ns",
    version = "0.1.0",
    src = "",
    script = list(list(src = "modernizr.custom.js", defer = NA),
                  list(src = "classie.js", defer = NA),
                  list(src = "notificationFx.js", defer = NA),
                  list(src = "buzz.js", defer = NA)),
    stylesheet = list("normalize.css",
                      "ns-default.css",
                      "ns-style-growl.css",
                      "ns-style-attached.css",
                      "ns-style-bar.css"),
    package = "standby"
  )
}

#' @rdname notify
#' @export
useNotify <- function() {

  htmltools::htmlDependency(
    name = "sby-pnotify",
    version = "0.1.0",
    src = "",
    script = list(list(src = "PNotify.js", defer = NA), 
                  list(src = "notify.js", defer = NA), 
                  list(src = "buzz.js", defer = NA)),
    stylesheet = list("PNotify.css",
                      "BrightTheme.css"),
    package = "standby"
  )
}

#' @rdname tingle
#' @export 
useTingle <- function() {
  htmltools::htmlDependency(
    name = "sby-tingle",
    version = "0.1.0",
    src = "",
    script = list(list(src = "tingle.min.js", defer = NA), 
                  list(src = "buzz.js", defer = NA)),
    stylesheet = "tingle.min.css",
    package = "standby"
  ) 
}

#' @rdname microTip
#' @export 
useMicroTip <- function() {
  htmltools::htmlDependency(
    name = "buzz-microtip",
    version = "0.1.0",
    src = "",
    script = list(src = "script.js", defer = NA),
    stylesheet = "microtip.min.css",
    package = "buzz"
  )
}

#' @rdname bootBox
#' @export 
useBootBox <- function() {
  htmltools::htmlDependency(
    name = "buzz-bootbox",
    version = "0.1.0",
    src = "",
    script = list(list(src = "bootbox.all.min.js", defer = NA), 
                  list(src = "script.js", defer = NA)),
    stylesheet = "animate.min.css",
    package = "buzz"
  )
}

#' @rdname alertify
#' @export 
useAlertify <- function() {
  htmltools::htmlDependency(
    name = "buzz-alertify",
    version = "0.1.0",
    src = "",
    script = list(list(src = "alertify.min.js", defer = NA), 
                  list(src = "buzz.js", defer = NA)),
    stylesheet = list("alertify.min.css",
                      "default.min.css",
                      "semantic.min.css",
                      "bootstrap.min.css"),
    package = "buzz"
  )
}
