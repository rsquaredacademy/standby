#' Notification Styles
#'
#' Simple website notifications with effects
#'
#' @param message Notification message. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param type Notification type. Defaults to \code{"notice"}. Other valid values are:
#' \itemize{
#' \item \code{"success"}
#' \item \code{"warning"}
#' \item \code{"error"}
#' }
#'   The notice, success, warning and error types have distinct background and
#'   foreground colours in every layout.
#' @param layout Notification layout. Defaults to \code{"growl"}. Other valid values are:
#' \itemize{
#' \item \code{"attached"}
#' \item \code{"bar"}
#' }
#' @param effect Notification effect type. The default \code{NULL} selects
#'   \code{"jelly"} for growl, \code{"flip"} for attached, or \code{"slidetop"}
#'   for bar. An explicit effect must be valid for the selected layout:
#' \itemize{
#' \item For \code{"growl"} layout
#' \itemize{
#' \item \code{"scale"}
#' \item \code{"jelly"}
#' \item \code{"slide"}
#' \item \code{"genie"}
#' }
#' \item For\code{"attached"} layout
#' \itemize{
#' \item \code{"flip"}
#' \item \code{"bouncyflip"}
#' }
#' \item For \code{"bar"} layout
#' \itemize{
#' \item \code{"slidetop"}
#' \item \code{"exploader"}
#' }
#' }
#' @param session Shiny session object.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useNS}: Dependencies to include in your UI.
#' \item \code{notice}: Display notifications.
#' }
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(standby)
#'
#' ui <- fluidPage(
#'
#'   useNS(), # include dependencies
#'   actionButton(inputId = "btn",
#'                label   = "Notice Demo")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$btn, {
#'     # display notification
#'     notice("Hey there! Thank you for exploring standby!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name notice
#' @return \code{useNS()} returns an HTML dependency to include in the UI.
#'   notice() sends a custom message to the Shiny session for its side effect
#'   and has no meaningful return value.
#'
#' @export
#'
notice <- function(message = "Hello", type = "notice", layout = "growl",
                   effect = NULL, session = getDefaultReactiveDomain()) {

  validate_choice(type, c("notice", "success", "warning", "error"), "type")
  validate_choice(layout, c("growl", "attached", "bar"), "layout")
  effects <- switch(layout, growl = c("jelly", "scale", "slide", "genie"),
    attached = c("flip", "bouncyflip"), bar = c("slidetop", "exploader"))
  if (is.null(effect)) effect <- effects[[1]]
  validate_choice(effect, effects, "effect")

  notice = list(
    message = message,
    layout  = layout,
    effect  = effect,
    type    = type
  )

  session$sendCustomMessage(
    type    = 'ns.send',
    message = notice
  )

}
