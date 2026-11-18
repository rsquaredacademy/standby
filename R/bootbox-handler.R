#' BootBox
#'
#' Bootstrap modals made easy.
#'
#' @param title Adds a header to the dialog. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param message Text displayed in the dialog. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param size Adds the relevant Bootstrap modal size class to the dialog wrapper. Valid values are:
#' \itemize{
#' \item \code{"small"}
#' \item \code{"large"}
#' \item \code{"extra-large"}
#' }
#'   With Shiny's default Bootstrap 3, extra-large uses a responsive width up to
#'   1140 pixels on viewports at least 992 pixels wide.
#'   The aliases \code{"sm"}, \code{"lg"}, and \code{"xl"} are also accepted;
#'   \code{NULL} or \code{""} uses the standard modal size.
#' @param close_on_escape Logical; if \code{TRUE} (the default), allows the user to dismiss the dialog by hitting \code{ESC} key.
#' @param show Logical; if \code{TRUE} (the default), the dialog is shown immediately.
#' @param backdrop Logical; if \code{TRUE}, the backdrop is displayed and clicking on it dismisses the dialog. Defaults to \code{NULL}.
#' Valid values are:
#' \itemize{
#' \item \code{NULL}: The backdrop is displayed, but clicking on it has no effect.
#' \item \code{TRUE}: The backdrop is displayed, and clicking on it dismisses the dialog.
#' \item \code{FALSE}: The backdrop is not displayed.
#' }
#'   The Bootbox value \code{"static"} is also accepted and behaves like \code{NULL}.
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
#' @return \code{useBootBox()} returns a Shiny tag list of HTML dependencies to include in the UI.
#'   bootBox() sends a custom message to the Shiny session for its side effect
#'   and has no meaningful return value.
#'
#' @export
#'
bootBox <- function(title = "Your title", message = "Your message here...", size = "small",
                    close_on_escape = TRUE, show = TRUE, backdrop = NULL, close_button = TRUE,
                    animate = TRUE, class = NULL,
                    session = getDefaultReactiveDomain()) {

  size <- validate_choice(size, c("small", "sm", "large", "lg", "extra-large", "xl", ""), "size", null = TRUE)
  if (!is.null(size) && size %in% c("sm", "lg", "xl")) {
    size <- c(sm = "small", lg = "large", xl = "extra-large")[[size]]
  }
  close_on_escape <- validate_flag(close_on_escape, "close_on_escape")
  show <- validate_flag(show, "show")
  close_button <- validate_flag(close_button, "close_button")
  animate <- validate_flag(animate, "animate")
  backdrop <- unname(backdrop)
  if (is.character(backdrop) && length(backdrop) == 1L &&
      !is.na(backdrop) && tolower(backdrop) == "static") {
    backdrop <- NULL
  } else {
    if (!is.null(backdrop) && (!is.logical(backdrop) ||
        length(backdrop) != 1L || is.na(backdrop))) {
      stop('`backdrop` must be TRUE or FALSE, NULL, or "static".', call. = FALSE)
    }
  }
  if (is.atomic(message)) message <- unname(message)
  if (is.null(message) || length(message) == 0L ||
      (is.atomic(message) && (length(message) != 1L || is.na(message) ||
        identical(message, FALSE) || (is.numeric(message) && isTRUE(message == 0)) ||
        identical(as.character(message), "")))) {
    stop("`message` must be non-empty text or HTML.", call. = FALSE)
  }

  notice = list(
    title       = title,
    message     = message,
    size        = size,
    onEscape    = close_on_escape,
    show        = show,
    backdrop    = backdrop,
    closeButton = close_button,
    animate     = animate,
    className   = if (!is.null(class)) paste0("animate__animated animate__", class) else NULL
  )

  session$sendCustomMessage(
    type    = "bootbox.send",
    message = notice
  )

}
