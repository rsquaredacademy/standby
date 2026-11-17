#' Three Dots
#'
#' Single element CSS loading animation.
#'
#' @param uiOutput An output element to be wrapped within a loader.
#' @param type The type of animation to use. Visit \url{https://nzbin.github.io/three-dots/} for details.
#' @param color The color of the loader. Choose between a color name, hexadecimal,
#'   or \code{rgb()}/\code{rgba()}/\code{hsl()}/\code{hsla()} values. Names use R's
#'   \code{colors()} values; CSS colour names not in R are also accepted.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useThreeDots}: Dependencies to include in your UI.
#' \item \code{threeDots}: Display loading animation.
#' }
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
#' @name threeDots
#' @return \code{useThreeDots()} returns a Shiny tag list of HTML dependencies to include in the UI;
#'   \code{threeDots()} returns a Shiny tag list wrapping \code{uiOutput}.
#'
#' @export
#'
threeDots <- function(uiOutput, type = "elastic", color = '#9880ff') {

  type <- match.arg(type, c("elastic", "pulse", "flashing", "collision", "revolution",
                            "carousel", "typing", "windmill", "bricks", "floating",
                            "fire", "spin", "falling", "stretching", "gathering",
                            "hourglass", "overtaking", "shuttle", "bouncing", "rolling"))
  validate_color(color, "color")
  color <- normalize_color(color)
  id <- generate_id("threedots")
  # The bundled stylesheet draws some dots from box-shadow declarations that
  # read --primary-color, so the variable must be set on each widget too.
  dots_css <- paste0('#', id, ', #', id, ':before, #', id, ':after { --primary-color: ',
                     color, '; --primary-color-faded: ', spinner_shade(color, 0.2),
                     '; color: ', color, '; background-color: ', color, ';}')

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
