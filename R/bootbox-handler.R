#' BootBox
#'
#' Bootstrap modals made easy.
#'
#' @param title Adds a header to the dialog.
#' @param message Text displayed in the dialog.
#' @param size Adds the relevant Bootstrap modal size class to the dialog wrapper. Valid values are:
#' \itemize{
#' \item \code{"small"}
#' \item \code{"large"}
#' \item \code{"extra-large"}
#' }
#' @param close_on_escape Logical; if \code{TRUE} (the default), allows the user to dismiss the dialog by hitting \code{ESC} key.
#' @param show Logical; if \code{TRUE} (the default), the dialog is shown immediately.
#' @param backdrop Logical; if \code{TRUE}, the backdrop is displayed and clicking on it dismisses the dialog. Defaults to \code{NULL}.
#' Valid values are:
#' \itemize{
#' \item \code{NULL}: The backdrop is displayed, but clicking on it has no effect.
#' \item \code{TRUE}: The backdrop is displayed, and clicking on it dismisses the dialog.
#' \item \code{FALSE}: The backdrop is not displayed.
#' }
#' @param close_button Logical; if \code{TRUE} (the default), a close button is displayed.
#' @param animate Logical; if \code{TRUE} (the default), animates the dialog in and out.
#' @param class Custom CSS class (using Animate.css).
#' @param session Shiny session object.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useBootBox}: Dependencies to include in your UI.
#' \item \code{bootBox}: Display modals.
#' }
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(standby)
#'
#' ui <- fluidPage(
#'
#'   useBootBox(), # include dependencies
#'   actionButton(inputId = "btn",
#'                label   = "BootBox Demo")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$btn, {
#'     # display modal
#'     bootBox("Hey there!", "Thank you for exploring standby!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name bootBox
#' @return None
#'
#' @export
#'
bootBox <- function(title = "Your title", message = "Your message here...", size = "small",
                    close_on_escape = TRUE, show = TRUE, backdrop = NULL, close_button = TRUE,
                    animate = TRUE, class = NULL,
                    session = getDefaultReactiveDomain()) {

  notice = list(
    title       = title,
    message     = message,
    size        = size,
    onEscape    = close_on_escape,
    show        = show,
    backdrop    = backdrop,
    closeButton = close_button,
    animate     = animate,
    className   = paste0("animate__animated animate__", class)
  )

  session$sendCustomMessage(
    type    = "bootbox.send",
    message = notice
  )

}
