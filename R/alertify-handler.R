#' Alertify
#'
#' Pretty browser alerts and notifications.
#'
#' @param title Dialog title. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param message Dialog contents. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param type Alert/notification type. Defaults to \code{"success"}. Valid values are:
#' \itemize{
#' \item \code{"success"}
#' \item \code{"error"}
#' \item \code{"warning"}
#' \item \code{"message"}
#' }
#' For \code{alertify_alert()} the type sets a class on the dialog and a
#' type-specific accent border and header colour. For
#' \code{alertify_notify()} it sets the notification style.
#' @param btn_label The \code{OK} button label. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param transition Transition effect to be used when showing/hiding the dialog. Defaults to \code{"pulse"}. Valid values are:
#' \itemize{
#' \item \code{"pulse"}
#' \item \code{"slide"}
#' \item \code{"zoom"}
#' \item \code{"fade"}
#' \item \code{"flipx"}
#' \item \code{"flipy"}
#' }
#' @param delay The time (in seconds) to wait before the notification is auto-dismissed. \code{0}, \code{Inf}, or \code{NULL} will keep notification open till clicked.
#'   The strings \code{"infinity"} and \code{"infinite"} also keep it open.
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
#' @param closable Logical; if \code{TRUE} (the default), a \code{Close} button is displayed in the header of the dialog.
#' @param auto_reset Logical; if \code{TRUE}, the dialog will reset size/position on window resize. Defaults to \code{FALSE}.
#' @param frameless Logical; if \code{TRUE}, hides both header and footer of the dialog. Defaults to \code{FALSE}.
#' @param maximizable Logical; if \code{TRUE}, the \code{Maximize} button is displayed in the header of the dialog. Defaults to \code{FALSE}.
#' @param modal Logical; if \code{TRUE}, a screen dimmer will be used and access to the page contents will be prevented. Defaults to \code{FALSE}.
#' @param movable Logical; if \code{TRUE}, the dialog is movable. Defaults to \code{FALSE}.
#' @param move_bounded Logical; if \code{TRUE} (the default), the dialog is not allowed to go off-screen.
#' @param overflow Logical; if \code{TRUE}, the content overflow is managed by the dialog. Defaults to \code{FALSE}.
#' @param padding Logical; if \code{TRUE} (the default), the content padding is managed by the dialog.
#' @param pinnable Logical; if \code{TRUE}, the \code{Pin} button is displayed in the header of the dialog. Defaults to \code{FALSE}.
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
#' library(standby)
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
#'     alertify_alert("Hey there!", "Thank you for exploring standby!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' # Example 2: Notification
#' if (interactive()) {
#' library(shiny)
#' library(standby)
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
#'     alertify_notify("Hey there! Thank you for exploring standby!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name alertify
#' @return \code{useAlertify()} returns an HTML dependency to include in the UI.
#'   alertify_alert() and alertify_notify() send a custom message to the Shiny session for its side effect
#'   and have no meaningful return value.
#'
NULL

#' @rdname alertify
#' @export
#'
alertify_alert <- function(title = "Alert Title", message = "Alert Message",
                           type = "success", btn_label = "OK",
                           transition = "pulse", transition_off = FALSE,
                           closable = TRUE, auto_reset = FALSE,
                           frameless = FALSE, maximizable = FALSE,
                           modal = FALSE, movable = FALSE, move_bounded = TRUE,
                           overflow = FALSE, padding = TRUE, pinnable = FALSE,
                           resizeable = FALSE, start_maximized = FALSE,
                           session = getDefaultReactiveDomain()) {

  type <- validate_choice(type, c("success", "error", "warning", "message"), "type")
  transition <- validate_choice(transition, c("pulse", "slide", "zoom", "fade", "flipx", "flipy"), "transition")
  transition_off <- validate_flag(transition_off, "transition_off")
  closable <- validate_flag(closable, "closable")
  auto_reset <- validate_flag(auto_reset, "auto_reset")
  frameless <- validate_flag(frameless, "frameless")
  maximizable <- validate_flag(maximizable, "maximizable")
  modal <- validate_flag(modal, "modal")
  movable <- validate_flag(movable, "movable")
  move_bounded <- validate_flag(move_bounded, "move_bounded")
  overflow <- validate_flag(overflow, "overflow")
  padding <- validate_flag(padding, "padding")
  pinnable <- validate_flag(pinnable, "pinnable")
  resizeable <- validate_flag(resizeable, "resizeable")
  start_maximized <- validate_flag(start_maximized, "start_maximized")

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
alertify_notify <- function(message = "Alert Message", type = "success",
                            delay = 5, position = "bottom-right",
                            session = getDefaultReactiveDomain()) {

  type <- validate_choice(type, c("success", "error", "warning", "message"), "type")
  position <- validate_choice(position, c("bottom-right", "bottom-left", "bottom-center",
    "top-right", "top-left", "top-center"), "position")
  # Alertify deliberately keeps notifications open for non-positive delays.
  if (is.null(delay) || is_infinite_delay(delay)) delay <- 0
  delay <- normalize_delay(delay, "delay", negative = TRUE)

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
