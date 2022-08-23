#' Three Dots
#'
#' Single element CSS loading animation.
#'
#' @param uiOutput An output element to be wrapped within a loader.
#' @param type The type of animation to use. Visit \url{https://nzbin.github.io/three-dots/} for details.
#' @param color The color of the loader. Choose between hexadecimal, RGB or keyword values.
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
#' @return \value{None}
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
