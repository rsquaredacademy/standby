#' @export
standby <- function(ui_element, type = "bouncing") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("dot-", type, " wait")
    ),
    ui_element
  )
}

#' @export
spinkit <- function(ui_element, type = "rotating-plane", width = NULL, height = NULL, bg_color = NULL) {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("sk-plane", " wait"),
      style = c(paste0('width:', width, ';'), 
                paste0('height:', height, ';'),
                paste0('background-color:', bg_color, ';'))
    ),
    ui_element
  )
}

#' @export 
vizLoad <- function(ui_element, type = "bars") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("lv-bars lv-mid lg", " wait"),
      lapply(1:8, function(i) div())
    ),
    ui_element
  )
}

#' @export 
spinners <- function(ui_element, type = "load1") {
  tags$div(
    class = "standby",
    tags$div(
      class = type,
      tags$div(class = "loader")
    ),
    ui_element
  )
}

