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
#' @param color Color of the spinner. Defaults to \code{"#333"}. Choose between hexadecimal, RGB or keyword values.
#' @param size Size of the spinner. Defaults to \code{"40px"}.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useSpinkit}: Dependencies to include in your UI.
#' \item \code{spinkit}: Display loading animation.
#' }
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
#' @name spinkit
#' @return None
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
