#' @export
glanceThreeDots <- function(type = "bouncing") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("dot-", type, " wait")
    )
  )
}

#' @export
glanceSpinkit <- function(type = "rotating-plane", width = NULL, height = NULL, bg_color = NULL) {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("sk-plane", " wait"),
      style = c(paste0('width:', width, ';'),
                paste0('height:', height, ';'),
                paste0('background-color:', bg_color, ';'))
    )
  )
}

#' @export
glanceVizLoad <- function(type = "bars") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("lv-bars lv-mid lg", " wait"),
      lapply(1:8, function(i) div())
    )
  )
}

#' @export
glanceSpinners <- function(type = "load1") {
  tags$div(
    class = "standby",
    tags$div(
      class = type,
      tags$div(class = "loader")
    )
  )
}

#' @export
glanceLoaders <- function(type = "default") {
  tags$div(
    class = "standby",
    tags$div(
      id = "loader",
      class = paste0("loader loader-", type, " is-active")
    )
  )
}

spinkit_plane <- function(width = NULL, height = NULL, bg_color = NULL) {
  tags$div(
    class = "sk-plane wait",
    style = c(if (!is.null(width)) paste0('width:', width, ';'),
              if (!is.null(height)) paste0('height:', height, ';'),
              if (!is.null(bg_color)) paste0('background-color:', bg_color, ';'))
  )
}

spinkit_chase <- function(width = NULL, height = NULL, bg_color = NULL) {
  tags$div(
    class = "sk-chase wait",
    lapply(1:6, function(i) div(class = "sk-chase-dot",
                                style = c(if (!is.null(width)) paste0('width:', width, ';'),
                                          if (!is.null(height)) paste0('height:', height, ';'),
                                          if (!is.null(bg_color)) paste0('background-color:', bg_color, ';'))))
  )
}

spinkit_bounce <- function() {
  tags$div(
    class = "sk-bounce wait",
    lapply(1:2, function(i) div(class = "sk-bounce-dot"))
  )
}

spinkit_wave <- function() {
  tags$div(
    class = "sk-wave wait",
    lapply(1:5, function(i) div(class = "sk-wave-rect"))
  )
}

spinkit_pulse <- function() {
  tags$div(
    class = "sk-pulse wait"
  )
}

spinkit_flow <- function() {
  tags$div(
    class = "sk-flow wait",
    lapply(1:3, function(i) div(class = "sk-flow-dot"))
  )
}

spinkit_swing <- function() {
  tags$div(
    class = "sk-swing wait",
    lapply(1:3, function(i) div(class = "sk-swing-dot"))
  )
}


spinkit_circle <- function() {
  tags$div(
    class = "sk-circle wait",
    lapply(1:12, function(i) div(class = "sk-circle-dot"))
  )
}

spinkit_circle_fade <- function() {
  tags$div(
    class = "sk-circle-fade wait",
    lapply(1:12, function(i) div(class = "sk-circle-fade-dot"))
  )
}

spinkit_grid <- function() {
  tags$div(
    class = "sk-grid wait",
    lapply(1:9, function(i) div(class = "sk-grid-cube"))
  )
}

spinkit_fold <- function() {
  tags$div(
    class = "sk-fold wait",
    lapply(1:4, function(i) div(class = "sk-fold-cube"))
  )
}

spinkit_wander <- function() {
  tags$div(
    class = "sk-wander wait",
    lapply(1:4, function(i) div(class = "sk-wander-cube"))
  )
}

# vizLoad
viz_bars <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lvl-5",
                  "tiny"   = "tiny lvl-5")

  tags$div(
    class = paste0("lv-bars ", scale, " wait"),
    lapply(1:8, function(i) div(
      style = c(if (!is.null(bg_color)) paste0('background-color:', bg_color, ';'))
    ))
  )
}

viz_squares <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lvl-5",
                  "tiny"   = "tiny lvl-5")

  tags$div(
    class = paste0("lv-squares ", scale, " wait"),
    lapply(1:4, function(i) div(
      style = c(if (!is.null(bg_color)) paste0('background-color:', bg_color, ';'))
    ))
  )
}

viz_circles <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lvl-5",
                  "tiny"   = "tiny lvl-5")

  tags$div(
    class = paste0("lv-circles ", scale, " wait"),
    lapply(1:12, function(i) div())
  )
}

viz_dots <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lvl-5",
                  "tiny"   = "tiny lvl-5")

  tags$div(
    class = paste0("lv-dots ", scale, " wait"),
    lapply(1:4, function(i) div())
  )
}

viz_spinner <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lvl-5",
                  "tiny"   = "tiny lvl-5")

  tags$div(
    class = paste0("lv-spinner ", scale, " wait"),
    div(
      style = c(if (!is.null(bg_color)) paste0('border-top: 10px solid ', bg_color, ';'))
    )
  )
}







