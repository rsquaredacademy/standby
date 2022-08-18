#' Three Dots
#' 
#' CSS loading animation displayed when output is being recalculated.
#' 
#' @param uiOutput An output element to be wrapped within a loader.
#' @param type The type of animation to use. Check out \url{https://nzbin.github.io/three-dots/} to see the #' different options.
#' @param color The color of the loader.
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
#' @param type The type of spinner to use. The following are valid types:
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
#' @param color The color of the spinner.
#' @param width The width of the spinner.
#' @param height The height of the spinner.
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
spinkit <- function(uiOutput, type = "plane", color = NULL, width = NULL, height = NULL) {

  base <- switch(type,
                "plane"       = spinkit_plane(color),
                "chase"       = spinkit_chase(color),
                "bounce"      = spinkit_bounce(color),
                "wave"        = spinkit_wave(color),
                "pulse"       = spinkit_pulse(color),
                "flow"        = spinkit_flow(color),
                "swing"       = spinkit_swing(color),
                "circle"      = spinkit_circle(color),
                "circle_fade" = spinkit_circle_fade(color),
                "grid"        = spinkit_grid(color),
                "fold"        = spinkit_fold(color),
                "wander"      = spinkit_wander(color))
  tags$div(
    class = "standby",
    base,
    uiOutput
  )
}

#' Loading Visualization
#' 
#' Loading bars and spinners.
#' 
#' @param uiOutput An output element to be wrapped within a spinner.
#' @param type The type of bar/spinner to use. The following are valid types:
#' \itemize{
#' \item bars
#' \item squares
#' \item circles
#' \item dots
#' \item spinner
#' \item dashed
#' \item line
#' \item bordered-line
#' }
#' @param color The color of the bar/spinner.
#' @param size The size of the bar/spinner. The following are valid:
#' \itemize{
#' \item Large
#' \item Medium
#' \item Small
#' \item Tiny
#' \item Fluid
#' }
#' @param add_label Logical; if \code{TRUE}, displays a label below the bar/spinner.
#' @param label The label to be displayed below the bar/spinner. \code{add_label} must 
#' be set to \code{TRUE} to display the label.
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
                "bordered-line" = viz_bordered_line(size, color))

  if (add_label) {
    base$attribs[["data-label"]] <- label
  }

  tags$div(
    class = "standby",
    base,
    uiOutput
  )
}

#' Single Element CSS Spinners
#' 
#' A collection of loading spinners animated with CSS
#' 
#' @param uiOutput An output element to be wrapped within a spinner.
#' @param type The type of spinner to use. Any integer between 1 and 8 is valid.
#' @param color The color of the spinner.
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
spinners <- function(uiOutput, type = "1", color = "#0275d8") {

  id <- uuid::UUIDgenerate()
  spin_css <- paste0('#', id, ', #', id, ':before, #', id, ':after { background: ', color, ';}', 
                    ' #', id, '{ color: ', color, ';}')

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
        tags$div(class = "loader", id = id)
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

