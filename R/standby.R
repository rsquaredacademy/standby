#' @export
threeDots <- function(ui_element, type = "bouncing") {
  
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("wait dot-", type),
      id = if(!is.null(id)) id
    ),
    ui_element
  )

}

#' @export
spinkit <- function(ui_element, type = "plane", width = NULL, height = NULL, bg_color = NULL) {
  tags$div(
    class = "standby",
    spinkit_plane(width, height, bg_color),
    ui_element
  )
}

#' @export 
vizLoad <- function(ui_element, type = "bars", size = "large", bg_color = NULL, add_label = FALSE, label = "Loading...") {

  base <- switch(type,
                "bars"          = viz_bars(size, bg_color),
                "squares"       = viz_squares(size, bg_color),
                "circles"       = viz_circles(size),
                "dots"          = viz_dots(size),
                "spinner"       = viz_spinner(size, bg_color),
                "dashed"        = viz_dashed(size, bg_color),
                "line"          = viz_line(size, bg_color),
                "bordered-line" = viz_bordered_line(size, bg_color))

  if (add_label) {
    base$attribs[["data-label"]] <- label
  }

  tags$div(
    class = "standby",
    base,
    ui_element
  )
}

#' @export 
spinners <- function(ui_element, type = "load1") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0(type, " wait"),
      tags$div(class = "loader")
    ),
    ui_element
  )
}

#' @export 
loaders <- function(ui_element, type = "default", style = NULL) {
  
  data_tag <- tags$div(
      id = "loader",
      class = paste0("loader loader-", type, " is-active wait")
    )

  data_tag$attribs[[paste0('data-', style)]] <- NA
  
  tags$div(
    class = "standby",
    data_tag,
    ui_element
  )
}

