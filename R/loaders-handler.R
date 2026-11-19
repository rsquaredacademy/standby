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
#' The \code{music} type uses the bundled animated \code{hey-oh} coin graphic.
#' @param style Custom styling for the loaders: \code{"half"}, \code{"inverse"},
#'   \code{"rounded"}, or \code{"blink"}. Use \code{NULL} for no custom style.
#'   \code{"half"} supports only \code{"default"}; \code{"inverse"} supports
#'   \code{"default"} and \code{"bar"}; \code{"rounded"} supports \code{"bar"}
#'   and \code{"bar-ping-pong"}; \code{"blink"} supports \code{"default"},
#'   \code{"bar"}, and \code{"border"}, blinking their text (\code{"Loading"}
#'   when \code{text = NULL}). Supported styles can be combined with custom text.
#'   Unsupported type/style or type/text combinations raise an error.
#' @param text Custom text. Available only for the following types:
#' \itemize{
#' \item default
#' \item bar
#' \item border
#' \item curtain
#' \item smartphone
#' }
#' Must be \code{NULL} or one non-missing character string.
#'
#' @details The supported domain is the listed types and type-specific style/text
#'   combinations. These loaders display a viewport overlay and require CSS
#'   animation enabled in a modern browser. Allow at least 320 by 320 pixels
#'   for the largest graphic at its default size.
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
#'       loaders(uiOutput = plotOutput("plot"),
#'               type = "default",
#'               style = "half",
#'               text = "Loading...")
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
#' @return \code{useLoaders()} returns a Shiny tag list of HTML dependencies to include in the UI;
#'   \code{loaders()} returns a Shiny tag wrapping \code{uiOutput}.
#'
#' @export
#'
loaders <- function(uiOutput, type = "default", style = NULL, text = NULL) {

  style <- validate_choice(style, c("half", "inverse", "rounded", "blink"), "style", null = TRUE)
  type <- match.arg(type, c("default", "bar", "bar-ping-pong", "border", "double",
                            "clock", "curtain", "pokeball", "ball", "smartphone",
                            "bouncing", "music"))
  style_types <- list(half = "default", inverse = c("default", "bar"),
    rounded = c("bar", "bar-ping-pong"), blink = c("default", "bar", "border"))
  if (!is.null(style) && !type %in% style_types[[style]]) {
    stop("`style = \"", style, "\"` is not supported for `type = \"", type,
      "\"`. Supported types: ", paste(style_types[[style]], collapse = ", "), ".", call. = FALSE)
  }
  text_types <- c("default", "bar", "border", "curtain", "smartphone")
  if (!is.null(text) && !type %in% text_types) {
    stop("`text` is not supported for `type = \"", type,
      "\"`. Supported types: ", paste(text_types, collapse = ", "), ".", call. = FALSE)
  }
  if (!is.null(text) && (!is.character(text) || length(text) != 1L || is.na(text))) {
    stop("`text` must be NULL or a single non-missing string.", call. = FALSE)
  }
  id <- generate_id("loader")

  data_tag <- tags$div(
      id = id,
      class = paste0("loader sby-loader loader-", type, " is-active standby-wait")
    )

  # The music graphic is defined only for the upstream data-* variants.
  if (type == "music") data_tag$attribs[['data-hey-oh']] <- NA

  if (!is.null(style)) {
    if (style == "blink") {
      data_tag$attribs[['data-text']] <- NA
      data_tag$attribs[['data-blink']] <- NA
    } else {
      attribute <- switch(style, half = "data-half", inverse = "data-inverse",
                          rounded = "data-rounded")
      data_tag$attribs[[attribute]] <- NA
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
