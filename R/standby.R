#' Three Dots
#' 
#' Single element CSS loading animation.
#' 
#' @param uiOutput An output element to be wrapped within a loader.
#' @param type The type of animation to use. Visit <https://nzbin.github.io/three-dots/> for details.
#' @param color The color of the loader. Choose between hexadecimal, RGB or keyword values.
#' 
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   shinyApp(
#'     ui = fluidPage(
#'       useThreeDots(),
#'       actionButton("render", "Render"),
#'       threeDots(plotOutput("plot"))
#'     ),
#'     server = function(input, output) {
#'       output$plot <- renderPlot({
#'         input$render
#'         Sys.sleep(3)
#'         hist(mtcars$mpg)
#'       })
#'     }
#'   )
#' }
#' 
#' @export
#' 
threeDots <- function(uiOutput, type = "elastic", color = '#9880ff') {

  id <- uuid::UUIDgenerate()
  dots_css <- paste0('#', id, ', #', id, ':before, #', id, ':after { color: ', color, '; background-color: ', color, ';}')

  shiny::tagList(
    tags$head(
      tags$style(
        HTML(
          dots_css
        )
      )
    ),
    
    tags$div(
      class = "standby",
      tags$div(
        class = paste0("standby-wait dot-", type),
        id = id
      ),
      uiOutput
    )
  ) 

}

#' SpinKit
#' 
#' Simple CSS spinners.
#' 
#' @param uiOutput An output element to be wrapped within a spinner.
#' @param type Type of spinner to use. Valid values are:
#' \itemize{
#' \item plane
#' \item chase
#' \item bounce
#' \item wave
#' \item pulse
#' \item flow
#' \item swing
#' \item circle
#' \item circle_fade
#' \item grid
#' \item fold
#' \item wander
#' }
#' @param color Color of the spinner. Defaults to `"#333"`. Choose between hexadecimal, RGB or keyword values.
#' @param size Size of the spinner. Defaults to `"40px"`.
#' 
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   shinyApp(
#'     ui = fluidPage(
#'       useSpinkit(),
#'       actionButton("render", "Render"),
#'       spinkit(plotOutput("plot"))
#'     ),
#'     server = function(input, output) {
#'       output$plot <- renderPlot({
#'         input$render
#'         Sys.sleep(3)
#'         hist(mtcars$mpg)
#'       })
#'     }
#'   )
#' }
#' 
#' @export
#' 
spinkit <- function(uiOutput, type = "plane", color = "#333", size = "40px") {

  base <- switch(type,
                "plane"       = spinkit_plane(color, size),
                "chase"       = spinkit_chase(size),
                "bounce"      = spinkit_bounce(color, size),
                "wave"        = spinkit_wave(color, size),
                "pulse"       = spinkit_pulse(color, size),
                "flow"        = spinkit_flow(color, size),
                "swing"       = spinkit_swing(color, size),
                "circle"      = spinkit_circle(size),
                "circle-fade" = spinkit_circle_fade(size),
                "grid"        = spinkit_grid(color, size),
                "fold"        = spinkit_fold(size),
                "wander"      = spinkit_wander(color, size))

  spin_css <- switch(type, 
                     "chase" = paste0(".sk-chase-dot:before {background-color: ", color, ";}"),
                     "circle" = paste0(".sk-circle-dot:before {background-color: ", color, ";}"),
                     "circle-fade" = paste0(".sk-circle-fade-dot:before {background-color: ", color, ";}"),
                     "fold" = paste0(".sk-fold-cube:before {background-color: ", color, ";}"),
                     NULL)
  

  shiny::tagList(
    tags$head(
      tags$style(
        HTML(
          spin_css
        )
      )
    ),

    tags$div(
      class = "standby",
      base,
      uiOutput
    )
  )
}

#' Loading Visualization
#' 
#' Loading bars and spinners.
#' 
#' @param uiOutput An output element to be wrapped within a spinner.
#' @param type The type of bar/spinner to use. Valid values are: 
#' \itemize{
#' \item bars
#' \item squares
#' \item circles
#' \item dots
#' \item spinner
#' \item dashed
#' \item line
#' \item bordered_line
#' }
#' @param color The color of the bar/spinner. Choose between hexadecimal, RGB or keyword values. 
#' @param size The size of the bar/spinner. Valid values are: 
#' \itemize{
#' \item large
#' \item medium
#' \item small
#' \item tiny
#' \item fluid
#' }
#' @param add_label Logical; if `TRUE`, displays a label below the bar/spinner. Defaults to `FALSE`.
#' @param label The label to be displayed below the bar/spinner. `add_label` must 
#' be set to `TRUE` to display the label.
#' 
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   shinyApp(
#'     ui = fluidPage(
#'       useVizLoad(),
#'       actionButton("render", "Render"),
#'       vizLoad(plotOutput("plot"))
#'     ),
#'     server = function(input, output) {
#'       output$plot <- renderPlot({
#'         input$render
#'         Sys.sleep(3)
#'         hist(mtcars$mpg)
#'       })
#'     }
#'   )
#' }
#' 
#' @export 
#' 
vizLoad <- function(uiOutput, type = "bars", size = "large", color = NULL, add_label = FALSE, label = "Loading...") {

  base <- switch(type,
                "bars"          = viz_bars(size, color),
                "squares"       = viz_squares(size, color),
                "circles"       = viz_circles(size),
                "dots"          = viz_dots(size),
                "spinner"       = viz_spinner(size, color),
                "dashed"        = viz_dashed(size, color),
                "line"          = viz_line(size, color),
                "bordered_line" = viz_bordered_line(size, color))

  if (add_label) {
    base$attribs[["data-label"]] <- label
    viz_css <- paste0(".lv-", type, "[data-label]:after { color: ", color, ";}")
  }

  if (type == "circles") {
    circle_css <- paste0(".lv-circles div:before { background-color: ", color, "; }")
  } else {
    circle_css <- NULL
  }

  shiny::tagList(
    tags$head(
      tags$style(
        HTML(
          viz_css,
          circle_css
        )
      )
    ),

    tags$div(
      class = "standby",
      base,
      uiOutput
    )
  )
}

#' Single Element CSS Spinners
#' 
#' A collection of loading spinners animated with CSS
#' 
#' @param uiOutput An output element to be wrapped within a spinner.
#' @param type Type of spinner to use. Any integer between 1 and 8 is valid.
#' @param color Color of the spinner. Choose between hexadecimal or keyword values. 
#' 
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   shinyApp(
#'     ui = fluidPage(
#'       useSpinners(),
#'       actionButton("render", "Render"),
#'       spinners(plotOutput("plot"))
#'     ),
#'     server = function(input, output) {
#'       output$plot <- renderPlot({
#'         input$render
#'         Sys.sleep(3)
#'         hist(mtcars$mpg)
#'       })
#'     }
#'   )
#' }
#' 
#' @export 
#' 
spinners <- function(uiOutput, type = 1, color = "#0275d8") {

  ltype <- paste0(".load", type)

  # if (type == 2 || type == 4 || type == 5) {
  #   spin_css <- paste0(ltype, " .loader { color: ", color, ";}")
  # } else {
  #   spin_css <- paste0(ltype, " .loader, ", ltype, " .loader:before, ", ltype, " .loader:after { background: ", color, "; } ", ltype, " .loader { color: ", color, ";}")
  # }

  if (type == 1) {
    spin_css <- paste0(ltype, " .loader, ", ltype, " .loader:before, ", ltype, " .loader:after { background: ", color, "; } ", ltype, " .loader { color: ", color, ";}")
  }

  if (type == 2) {
    spin_css <- paste0(ltype, " .loader { color: ", color, ";}")
  }  

  if (type == 3) {
    spin_css <- paste0(ltype, " .loader:before { background: ", color, ";}")
  }

  if (type == 4 || type == 6 || type == 7) {
    spin_css <- paste0(ltype, " .loader { color: ", color, ";}")
  }

  if (type == 8) {
    col_rgb <- col2rgb(color)
    rgb_color <- paste0("rgba(", paste0(col_rgb, collapse = ","), ",", 0.2, ")")
    spin_css <- paste0(ltype, " .loader { border-left-color: ", color, "; border-top-color: ", rgb_color, "; border-right-color: ", rgb_color, "; border-bottom-color: ", rgb_color, ";}")
  }
  
  shiny::tagList(
    tags$head(
      tags$style(
        HTML(
          spin_css
        )
      )
    ),

    tags$div(
      class = "standby",
      tags$div(
        class = paste0(paste0("load", type), " standby-wait"),
        tags$div(class = "loader")
      ),
      uiOutput
    )
  )
}

#' CSS Loaders
#' 
#' Simple CSS loaders
#' 
#' @param uiOutput An output element to be wrapped within a loader.
#' @param type The type of loader to use. heck out \url{https://css-loader.raphaelfabeni.com/} to see the   #' different options.
#' \itemize{
#' \item default
#' \item bar
#' \item bar-ping-pong
#' \item border
#' \item double
#' \item clock
#' \item curtain
#' \item pokeball
#' \item ball
#' \item smartphone
#' \item bouncing
#' \item music
#' }
#' @param style Custom styling for the loaders.
#' 
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   shinyApp(
#'     ui = fluidPage(
#'       useSpinners(),
#'       actionButton("render", "Render"),
#'       spinners(plotOutput("plot"))
#'     ),
#'     server = function(input, output) {
#'       output$plot <- renderPlot({
#'         input$render
#'         Sys.sleep(3)
#'         hist(mtcars$mpg)
#'       })
#'     }
#'   )
#' }
#' 
#' @export 
#' 
loaders <- function(uiOutput, type = "default", style = NULL) {
  
  data_tag <- tags$div(
      id = "loader",
      class = paste0("loader loader-", type, " is-active standby-wait")
    )

  data_tag$attribs[[paste0('data-', style)]] <- NA
  
  tags$div(
    class = "standby",
    data_tag,
    uiOutput
  )
}

