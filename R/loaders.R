#' CSS Loaders
#'
#' Simple CSS loaders
#'
#' @param uiOutput An output element to be wrapped within a loader.
#' @param type The type of loader to use. Visit \url{https://css-loader.raphaelfabeni.com/} for details.
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
#' @param text Custom text. Available only for the following types:
#' \itemize{
#' \item default
#' \item bar
#' \item border
#' \item curtain
#' \item smartphone
#' }
#'
#' @section Functions:
#' \itemize{
#' \item \code{useLoaders}: Dependencies to include in your UI.
#' \item \code{loaders}: Display loading animation.
#' }
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'
#'   shinyApp(
#'     ui = fluidPage(
#'       useLoaders(),
#'       actionButton("render", "Render"),
#'       loaders(plotOutput("plot"))
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
#' @name loaders
#' @return None
#'
#' @export
#'
loaders <- function(uiOutput, type = "default", style = NULL, text = NULL) {

  if (!is.null(text)) {
    style <- NULL
  }

  data_tag <- tags$div(
      id = "loader",
      class = paste0("loader loader-", type, " is-active standby-wait")
    )

  if (!is.null(style)) {
    if (style == "blink") {
      data_tag$attribs[['data-text data-blink']] <- NA
    } else {
      data_tag$attribs[[paste0('data-', style)]] <- NA
    }
  }

  if (!is.null(text)) {
    if (type == "curtain") {
      data_tag$attribs[['data-curtain-text']] <- text
    } else if (type == "smartphone") {
      data_tag$attribs[['data-screen']] <- text
    } else {
      data_tag$attribs[['data-text']] <- text
    }
  }

    tags$div(
      class = "standby",
      data_tag,
      uiOutput
    )
}
