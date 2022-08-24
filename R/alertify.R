#' Alertify
#'
#' Pretty browser alerts and notifications.
#'
#' @param title Dialog title.
#' @param message Dialog contents.
#' @param type Dialog type. Defaults to \code{"success"}. Valid values are:
#' \itemize{
#' \item \code{"success"}
#' \item \code{"error"}
#' \item \code{"warning"}
#' \item \code{"message"}
#' }
#' @param btn_label The \code{OK} button label.
#' @param transition Transition effect to be used when showing/hiding the dialog. Defaults to \code{"pulse"}. Valid values are:
#' \itemize{
#' \item \code{"pulse"}
#' \item \code{"slide"}
#' \item \code{"zoom"}
#' \item \code{"fade"}
#' \item \code{"flipx"}
#' \item \code{"flipy"}
#' }
#' @param delay The time (in seconds) to wait before the notification is auto-dismissed. \code{0} will keep notification open till clicked.
#' @param position Position of the notification. Defaults to \code{"bottom-right"}. Valid values are:
#' \itemize{
#' \item \code{"bottom-right"}
#' \item \code{"bottom-left"}
#' \item \code{"bottom-center"}
#' \item \code{"top-right"}
#' \item \code{"top-left"}
#' \item \code{"top-center"}
#' }
#' @param transition_off Logical; if \code{TRUE}, transition effect is disabled. Defaults to \code{FALSE}.
#' @param closable Logical; if \code{TRUE} (the default), a |code{Close} button is displayed in the header of the dialog.
#' @param auto_reset Logical; if \code{TRUE} (the default), the dialog will reset size/position on window resize.
#' @param frameless Logical; if \code{TRUE}, hides both header and footer of the dialog. Defaults to \code{FALSE}.
#' @param maximizable Logical; if \code{TRUE} (the default), the \code{Maximize} button is displayed in the header of the dialog.
#' @param modal Logical; if \code{TRUE} (the default), a screen dimmer will be used and access to the page contents will be prevented.
#' @param movable Logical; if \code{TRUE} (the default), the dialog is movable.
#' @param move_bounded Logical; if \code{TRUE}, the dialog is not allowed to go off-screen. Defaults to \code{FALSE}.
#' @param overflow Logical; if \code{TRUE} (the default), the content overflow is managed by the dialog
#' @param padding Logical; if \code{TRUE} (the default), the content padding is managed by the dialog.
#' @param pinnable Logical; if \code{TRUE} (the default), the \code{Pin} button is displayed in the header of the dialog.
#' @param resizeable Logical; if \code{TRUE}, the dialog is resizable. Defaults to \code{FALSE}.
#' @param start_maximized Logical; if \code{TRUE}, the dialog will start in a maximized state. Defaults to \code{FALSE}.
#' @param session Shiny session object.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useAlertify}: Dependencies to include in your UI.
#' \item \code{alertify_alert}: Display alerts.
#' \item \code{alertify_notify}: Display notifications.
#' }
#'
#' @examples
#'
#' # Example 1: Alert
#' if (interactive()) {
#' library(shiny)
#' library(buzz)
#'
#' ui <- fluidPage(
#'
#'   useAlertify(), # include dependencies
#'   actionButton(inputId = "btn",
#'                label   = "Alert Demo")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$btn, {
#'     # display alert
#'     alertify_alert("Hey there!", "Thank you for exploring buzz!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' # Example 2: Notification
#' if (interactive()) {
#' library(shiny)
#' library(buzz)
#'
#' ui <- fluidPage(
#'
#'   useAlertify(), # include dependencies
#'   actionButton(inputId = "btn",
#'                label   = "Notification Demo")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$btn, {
#'     # display notification
#'     alertify_notify("Hey there! Thank you for exploring buzz!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name alertify
#' @return None
#'
NULL

#' @rdname alertify
#' @export
#'
alertify_alert <- function(title = "Alert Title", message = "Alert Message", type = "success",
                           btn_label = "OK", transition = "pulse", transition_off = FALSE,
                           closable = TRUE, auto_reset = FALSE, frameless = FALSE,
                           maximizable = FALSE, modal = FALSE, movable = FALSE, move_bounded = TRUE,
                           overflow = FALSE, padding = TRUE, pinnable = FALSE, resizeable = FALSE,
                           start_maximized = FALSE,
                           session = getDefaultReactiveDomain()) {

  notice = list(
    title          = title,
    message        = message,
    type           = type,
    label          = btn_label,
    autoReset      = auto_reset,
    closable       = closable,
    frameless      = frameless,
    maximizable    = maximizable,
    movable        = movable,
    modal          = modal,
    moveBounded    = move_bounded,
    overflow       = overflow,
    padding        = padding,
    pinnable       = pinnable,
    resizeable     = resizeable,
    startMaximized = start_maximized,
    transition     = transition,
    transitionOff  = transition_off
  )

  session$sendCustomMessage(
    type    = "alertify.alert",
    message = notice
  )
}

#' @rdname alertify
#' @export
#'
alertify_notify <- function(message = "Alert Message", type = "success", delay = 5,
                            position = "bottom-right",
                            session = getDefaultReactiveDomain()) {

  notice = list(
    message  = message,
    type     = type,
    delay    = delay,
    position = position
  )

  session$sendCustomMessage(
    type    = "alertify.notify",
    message = notice
  )
}
