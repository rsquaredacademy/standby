#' MicroTip
#'
#' Minimal CSS only tooltip.
#'
#' @param id The id of the element to attach the tooltip.
#' @param tip Content of the tooltip.
#' @param position Where the tooltip should appear relative to the target element. Defaults to \code{"top"}. Valid values are:
#' \itemize{
#' \item \code{"top"}
#' \item \code{"bottom"}
#' \item \code{"left"}
#' \item \code{"right"}
#' \item \code{"top-left"}
#' \item \code{"top-right"}
#' \item \code{"bottom-left"}
#' \item \code{"bottom-right"}
#' }
#' @param size Size of the tooltip. Defaults to \code{"fit"} as the tooltip will takeup only the size it requires to show the text.
#' Valid values are:
#' \itemize{
#' \item \code{"fit"}
#' \item \code{"small"}
#' \item \code{"medium"}
#' \item \code{"large"}
#' }
#' @param session Shiny session object.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useMicroTip}: Dependencies to include in your UI.
#' \item \code{microTip}: Add tooltip.
#' }
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(standby)
#'
#' ui <- fluidPage(
#'
#'   useMicroTip(), # include dependencies
#'   br(), br(), br(), br(),
#'   actionButton(inputId = "btn",
#'                label   = "MicroTip Demo")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   # display tooltip
#'   microTip(id = "btn",
#'            tip = "Hey there! This is a micro tip!",
#'            position = "bottom-right")
#'
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name microTip
#' @return None
#'
#' @export
#'
microTip <- function(id = NULL, tip = "Hey! tooltip!", position = "top", size = NULL,
                     session = getDefaultReactiveDomain()) {

  notice = list(
    id       = id,
    tip      = tip,
    position = position,
    size     = size
  )

  session$sendCustomMessage(
    type    = 'tip.send',
    message = notice
  )
}
