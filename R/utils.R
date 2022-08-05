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