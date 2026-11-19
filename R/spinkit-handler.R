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
#' \item circle-fade
#' \item grid
#' \item fold
#' \item wander
#' }
#' @param color Color of the spinner. Defaults to \code{"#333"}. Choose between a
#'   color name, hexadecimal, or \code{rgb()}/\code{rgba()}/\code{hsl()}/\code{hsla()}
#'   values. Names use R's \code{colors()} values; CSS colour names not in R are
#'   also accepted.
#' @param size Size of the spinner as a positive CSS length. Bare numbers and unitless
#'   numeric strings are interpreted as pixels. Defaults to \code{"40px"}.
#'
#' @details The supported domain is the listed types, colour formats, and finite
#'   positive CSS sizes. The output must have enough room for the requested size.
#'   CSS animation must be enabled in a modern browser. Transparent colours
#'   intentionally hide the spinner.
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
#'       spinkit(plotOutput("plot"), type = "circle-fade")
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
#' @return \code{useSpinkit()} returns a Shiny tag list of HTML dependencies to include in the UI;
#'   \code{spinkit()} returns a Shiny tag list wrapping \code{uiOutput}.
#'
#' @export
#'
spinkit <- function(uiOutput, type = "plane", color = "#333", size = "40px") {
  types <- c("plane", "chase", "bounce", "wave", "pulse", "flow", "swing",
             "circle", "circle-fade", "grid", "fold", "wander")
  if (!is.character(type) || length(type) != 1L || is.na(type) || !type %in% types) {
    stop("`type` must be one of: ", paste(types, collapse = ", "), ".", call. = FALSE)
  }
  color <- validate_color(color, "color")
  color <- normalize_color(color)
  size <- normalize_css_length(size, name = "size", strict = TRUE)
  magnitude <- if (is.null(size)) NA_real_ else {
    number <- regmatches(size, regexpr(sub("\\$$", "", css_number_regex), size, perl = TRUE))
    suppressWarnings(as.numeric(number))
  }
  if (length(magnitude) != 1L || !is.finite(magnitude) || magnitude <= 0) {
    stop("Invalid `size`: expected a positive CSS length (greater than zero).", call. = FALSE)
  }
  id <- generate_id("spinkit")
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
  if (type == "wander" && !is.null(size)) {
    base$attribs$style <- paste0(base$attribs$style, " --sk-size: ", size, ";")
  }

  # Some types colour a pseudo-element in the stylesheet, so the rule has to be
  # scoped to this widget or the last widget wins for every instance.
  pseudo_element <- switch(type,
                           "chase"       = ".sk-chase-dot:before",
                           "circle"      = ".sk-circle-dot:before",
                           "circle-fade" = ".sk-circle-fade-dot:before",
                           "fold"        = ".sk-fold-cube:before",
                           NULL)
  spin_css <- if (!is.null(pseudo_element)) {
    base$attribs$id <- id
    paste0("#", id, " ", pseudo_element, " {background-color: ", color, ";}")
  } else {
    NULL
  }


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
