#' Three Dots
#'
#' Single element CSS loading animation.
#'
#' @param uiOutput An output element to be wrapped within a loader.
#' @param type The type of animation to use. Visit \url{https://nzbin.github.io/three-dots/} for details.
#'   Supported types are \code{elastic}, \code{pulse}, \code{flashing},
#'   \code{collision}, \code{revolution}, \code{carousel}, \code{typing},
#'   \code{windmill}, \code{bricks}, \code{floating}, \code{fire}, \code{spin},
#'   \code{falling}, \code{stretching}, \code{gathering}, \code{hourglass},
#'   \code{overtaking}, \code{shuttle}, \code{bouncing}, and \code{rolling}.
#' @param color The color of the loader. Choose between a color name, hexadecimal,
#'   or \code{rgb()}/\code{rgba()}/\code{hsl()}/\code{hsla()} values. Names use R's
#'   \code{colors()} values; CSS colour names not in R are also accepted.
#'   The emoji types \code{bouncing} and \code{rolling} retain their native colours.
#'
#' @details The supported domain is the listed types and colour formats, rendered
#'   with CSS animation enabled in a modern browser and sufficient room in the
#'   output for the animation. Transparent colours intentionally hide the dots.
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
  color <- validate_color(color, "color")
  color <- normalize_color(color)
  id <- generate_id("threedots")
  # The bundled stylesheet draws some dots from box-shadow declarations that
  # read --primary-color, so the variable must be set on each widget too.
  dots_css <- paste0('#', id, ', #', id, ':before, #', id, ':after { --primary-color: ',
                     color, '; --primary-color-faded: ', spinner_shade(color, 0.2),
                     '; color: ', color, ';}')

  dots <- tags$div(class = paste0("dot-", type), id = id)
  if (type %in% c("pulse", "carousel", "typing", "bricks", "fire", "falling")) {
    # These types project solid shadows from an off-screen element. Center a
    # separate wrapper so standby positioning cannot override their left offset.
    # Moving the shadows to zero would clip their centres against the anchor.
    dots <- tags$div(class = "standby-wait sby-dot-projection", dots)
  } else {
    dots$attribs$class <- paste("standby-wait", dots$attribs$class)
  }

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
      dots,
      uiOutput
    )
  )

}
