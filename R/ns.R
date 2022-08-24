#' Notification Styles
#'
#' Simple website notifications with effects
#'
#' @param message Notification message.
#' @param type Notification type. Defaults to \code{"notice"}. Other valid values are:
#' \itemize{
#' \item \code{"success"}
#' \item \code{"warning"}
#' \item \code{"error"}
#' }
#' @param layout Notification layout. Defaults to \code{"growl"}. Other valid values are:
#' \itemize{
#' \item \code{"attached"}
#' \item \code{"bar"}
#' }
#' @param effect Notification effect type. Valid values include:
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
#' library(buzz)
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
#'     notice("Hey there! Thank you for exploring buzz!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name notice
#' @return None
#'
#' @export
#'
notice <- function(message = "Hello", type = "notice", layout = "growl",
                   effect = "jelly", session = getDefaultReactiveDomain()) {

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
