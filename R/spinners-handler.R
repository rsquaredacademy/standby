#' Single Element CSS Spinners
#'
#' A collection of loading spinners animated with CSS
#'
#' @param uiOutput An output element to be wrapped within a spinner.
#' @param type Type of spinner to use. Any integer between \code{1} and \code{8} is valid.
#' @param color Color of the spinner. Choose between hexadecimal or keyword values.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useSpinners}: Dependencies to include in your UI.
#' \item \code{spinners}: Display loading animation.
#' }
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
#' @name spinners
#' @return None
#'
#' @export
#'
spinners <- function(uiOutput, type = 1, color = "#0275d8") {

  ltype <- paste0(".load", type)

  if (type == 1) {
    spin_css <- paste0(ltype, " .loader, ", ltype, " .loader:before, ", ltype, " .loader:after { background: ", color, "; } ", ltype, " .loader { color: ", color, ";}")
  }

  if (type == 2) {
    spin_css <- paste0(ltype, " .loader { color: ", color, ";}")
  }

  if (type == 3) {
    spin_css <- paste0(ltype, " .loader:before { background: ", color, "; } ", ltype, " .loader { background: linear-gradient(to right, ", color, " 10%, rgba(255, 255, 255, 0) 42%); }")
  }

  if (type == 4 || type == 6 || type == 7) {
    spin_css <- paste0(ltype, " .loader { color: ", color, ";}")
  }

  if (type == 5) {
    spin_css <- spinner_css(color)
  }

  if (type == 8) {
    col_rgb <- grDevices::col2rgb(color)
    rgb_color <- paste0("rgba(", paste0(col_rgb, collapse = ","), ",", 0.2, ")")
    spin_css <- paste0(ltype, " .loader { border-left-color: ", color, "; border-top-color: ", rgb_color, "; border-right-color: ", rgb_color, "; border-bottom-color: ", rgb_color, ";}")
  }

  custom_css <- paste0(ltype, " .loader { margin: auto; position: absolute; top: 0; left: 0; right: 0; bottom: 0; }")

  shiny::tagList(
    tags$head(
      tags$style(
        HTML(
          spin_css,
          custom_css
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
