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
#' @param color The color of the bar/spinner. Choose between a color name,
#'   hexadecimal, or \code{rgb()}/\code{rgba()}/\code{hsl()}/\code{hsla()} values.
#'   Names use R's \code{colors()} values; CSS colour names not in R are also
#'   accepted.
#' @param size The size of the bar/spinner. For \code{"line"} and \code{"bordered_line"},
#' valid values are \code{"large"}, \code{"medium"}, \code{"small"}, and \code{"fluid"}.
#' For all other types, valid values are \code{"large"}, \code{"medium"}, \code{"small"},
#' and \code{"tiny"}.
#' Supply one non-missing character string. Line widths are capped at the output
#' width when the nominal preset is larger than its container.
#' @param add_label Logical; if \code{TRUE}, displays a label below the bar/spinner. Defaults to \code{FALSE}.
#' @param label The label to be displayed below the bar/spinner. \code{add_label} must
#' be set to \code{TRUE} to display the label.
#'
#' @details The supported domain is the listed type/size combinations and colour
#'   formats, with CSS animation enabled in a modern browser and sufficient room
#'   for the chosen graphic. Transparent colours intentionally hide the graphic.
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
#' @return \code{useVizLoad()} returns a Shiny tag list of HTML dependencies to include in the UI;
#'   \code{vizLoad()} returns a Shiny tag list wrapping \code{uiOutput}.
#'
#' @export
#'
vizLoad <- function(uiOutput, type = "bars", size = "large", color = NULL, add_label = FALSE, label = "Loading...") {

  add_label <- validate_flag(add_label, "add_label")
  type <- match.arg(type, c("bars", "squares", "circles", "dots", "spinner", "dashed", "line", "bordered_line"))

  valid_sizes <- if (type %in% c("line", "bordered_line")) {
    c("fluid", "large", "medium", "small")
  } else {
    c("large", "medium", "small", "tiny")
  }

  size <- validate_choice(size, valid_sizes, "size")
  if (!is.null(color)) {
    color <- validate_color(color, "color")
    color <- normalize_color(color)
  }
  id <- generate_id("viz")

  base <- switch(type,
                "bars"          = viz_bars(size, color),
                "squares"       = viz_squares(size, color),
                "circles"       = viz_circles(size),
                "dots"          = viz_dots(size, color),
                "spinner"       = viz_spinner(size, color),
                "dashed"        = viz_dashed(size, color),
                "line"          = viz_line(size, color),
                "bordered_line" = viz_bordered_line(size, color))

  if (add_label) {
    base$attribs[["data-label"]] <- label
    viz_css <- if (!is.null(color)) paste0("#", id, " .lv-", type, "[data-label]:after { color: ", color, ";}") else NULL
  } else {
    viz_css <- NULL
  }

  if (type == "circles") {
    circle_css <- if (!is.null(color)) paste0("#", id, " .lv-circles div:before { background-color: ", color, "; }") else NULL
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
      id = id,
      class = "standby",
      base,
      uiOutput
    )
  )
}
