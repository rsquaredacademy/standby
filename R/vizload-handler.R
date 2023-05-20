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
#' @param add_label Logical; if \code{TRUE}, displays a label below the bar/spinner. Defaults to \code{FALSE}.
#' @param label The label to be displayed below the bar/spinner. \code{add_label} must
#' be set to \code{TRUE} to display the label.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useVizLoad}: Dependencies to include in your UI.
#' \item \code{vizLoad}: Display loading animation.
#' }
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
#' @name vizLoad
#' @return None
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
  } else {
    viz_css <- NULL
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
