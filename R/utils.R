glanceThreeDots <- function(type = "elastic") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("dot-", type, " standby-wait")
    )
  )
}

glanceSpinkit <- function(type = "rotating-plane", color = NULL, width = NULL, height = NULL) {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("sk-plane", " standby-wait"),
      style = c(paste0('width:', width, ';'),
                paste0('height:', height, ';'),
                paste0('background-color:', color, ';'))
    )
  )
}

glanceVizLoad <- function(type = "bars") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("lv-bars lv-mid lg", " standby-wait"),
      lapply(1:8, function(i) div())
    )
  )
}

glanceSpinners <- function(type = "load1") {
  tags$div(
    class = "standby",
    tags$div(
      class = type,
      tags$div(class = "loader")
    )
  )
}

glanceLoaders <- function(type = "default") {
  tags$div(
    class = "standby",
    tags$div(
      id = "loader",
      class = paste0("loader loader-", type, " is-active")
    )
  )
}

spinkit_plane <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-plane standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";"),
              if (!is.null(color)) paste0('background-color: ', color, ';'))
  )
}

spinkit_chase <- function(size = NULL) {
  tags$div(
    class = "sk-chase standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:6, function(i) div(class = "sk-chase-dot"))
  )
}

spinkit_bounce <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-bounce standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:2, function(i) div(class = "sk-bounce-dot",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_wave <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-wave standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:5, function(i) div(class = "sk-wave-rect",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_pulse <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-pulse standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";"),
              if (!is.null(color)) paste0('background-color:', color, ';'))
  )
}

spinkit_flow <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-flow standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:3, function(i) div(class = "sk-flow-dot",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_swing <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-swing standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:3, function(i) div(class = "sk-swing-dot",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}


spinkit_circle <- function(size = NULL) {
  tags$div(
    class = "sk-circle standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:12, function(i) div(class = "sk-circle-dot"))
  )
}

spinkit_circle_fade <- function(size = NULL) {
  tags$div(
    class = "sk-circle-fade standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:12, function(i) div(class = "sk-circle-fade-dot"))
  )
}

spinkit_grid <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-grid standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:9, function(i) div(class = "sk-grid-cube",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_fold <- function(size = NULL) {
  tags$div(
    class = "sk-fold standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:4, function(i) div(class = "sk-fold-cube"))
  )
}

spinkit_wander <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-wander standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:4, function(i) div(class = "sk-wander-cube",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
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
    class = paste0("lv-bars ", scale, " standby-wait"),
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
    class = paste0("lv-squares ", scale, " standby-wait"),
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
    class = paste0("lv-circles ", scale, " standby-wait"),
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
    class = paste0("lv-dots ", scale, " standby-wait"),
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
    class = paste0("lv-spinner ", scale, " standby-wait"),
    div(
      style = c(if (!is.null(bg_color)) paste0('border-top: 10px solid ', bg_color, ';'))
    )
  )
}

viz_dashed <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lvl-5",
                  "tiny"   = "tiny lvl-5")

  tags$div(
    class = paste0("lv-dashed ", scale, " standby-wait"),
    div(
      style = c(if (!is.null(bg_color)) paste0('border: 12px dashed ', bg_color, ';'))
    )
  )
}

viz_line <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "fluid"  = "lv-mid",
                  "large"  = "lg lv-mid",
                  "medium" = "md lv-mid",
                  "small"  = "sm lv-mid")

  tags$div(
    class = paste0("lv-line ", scale, " standby-wait"),
    style = c("height: 5px;"),
    div(
      style = c(if (!is.null(bg_color)) paste0('background-color: ', bg_color, ';'),
                'height: 5px;')
    )
  )
}

viz_bordered_line <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "fluid"  = "lv-mid",
                  "large"  = "lg lv-mid",
                  "medium" = "md lv-mid",
                  "small"  = "sm lv-mid")

  tags$div(
    class = paste0("lv-bordered_line ", scale, " standby-wait"),
    style = c("height: 21px;",
              if (!is.null(bg_color)) paste0('border: 5px solid ', bg_color, ';')),
    div(
      style = c(if (!is.null(bg_color)) paste0('background-color: ', bg_color, ';'),
                'height: 5px;')
    )
  )
}







