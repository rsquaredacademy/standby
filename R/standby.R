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
  tags$div(
    class = "standby",
    spinkit_plane(width, height, color),
    uiOutput
  )
}

#' @export 
vizLoad <- function(uiOutput, type = "bars", size = "large", bg_color = NULL, add_label = FALSE, label = "Loading...") {

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
    uiOutput
  )
}

#' @export 
spinners <- function(uiOutput, type = "load1", color = "#0275d8") {

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
        class = paste0(type, " standby-wait"),
        tags$div(class = "loader", id = id)
      ),
      uiOutput
    )
  )
}

#' @export 
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

