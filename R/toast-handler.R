#' iziToast
#'
#' Lightweight toast notifications
#'
#' @param title Title of the toast. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param message Message of toast. Interpreted as HTML. Escape untrusted input with \code{htmltools::htmlEscape()}.
#' @param type Type of notification. Defaults to \code{NULL}. Valid values are:
#' \itemize{
#' \item \code{"info"}
#' \item \code{"success"}
#' \item \code{"warning"}
#' \item \code{"error"}
#' \item \code{"question"}
#' }
#' @param theme Theme of toast: \code{"light"}, \code{"dark"}, or a custom theme
#'   name used as the suffix of the \code{iziToast-theme-} class. Must be one
#'   non-NA string without whitespace or quotes; \code{NULL} or \code{""} uses
#'   the default theme.
#' @param position Where toast will be shown. Defaults to \code{"center"}. Valid values are:
#' \itemize{
#' \item \code{"bottomRight"}
#' \item \code{"bottomLeft"}
#' \item \code{"topRight"}
#' \item \code{"topLeft"}
#' \item \code{"topCenter"}
#' \item \code{"bottomCenter"}
#' \item \code{"center"}
#' }
#' @param duration Time in milliseconds to close the toast. Defaults to \code{5000}. Use \code{FALSE}, \code{Inf}, or \code{NULL} to disable.
#'   The strings \code{"infinity"} and \code{"infinite"} also disable closing.
#'   For compatibility, \code{0}, \code{NA}, \code{NaN}, and \code{-Inf}
#'   also keep the toast open.
#' @param progress_bar_color Progress bar color. Choose between hexadecimal, RGB or keyword values.
#' @param background_color Background color of the toast. Choose between hexadecimal, RGB or keyword values.
#' @param max_width Maximum width of the toast.
#' @param title_color Title color. Choose between hexadecimal, RGB or keyword values.
#' @param title_size Title font size. A bare number is interpreted as pixels.
#' @param title_line_height Title line height. A bare number is interpreted as pixels.
#' @param message_color Message color. Choose between hexadecimal, RGB or keyword values.
#' @param message_size Message font size. A bare number is interpreted as pixels.
#' @param message_line_height Message line height. A bare number is interpreted as pixels.
#' @param image Cover image.
#' @param image_width Width of cover image. Defaults to \code{"50px"}. A bare
#'   number is interpreted as pixels.
#' @param zindex The z-index CSS attribute of the toast. Defaults to \code{99999}.
#' @param layout Size of the toast. Choose between \code{1}, \code{2}, or \code{3}.
#' @param balloon Logical; if \code{TRUE}, applies a balloon like toast. Defaults to \code{FALSE}.
#' @param close Logical; if \code{TRUE} (the default), shows a \code{x} close button.
#' @param close_on_escape Logical; if \code{TRUE}, allows to close toast using ESC key. Defaults to \code{FALSE}.
#' @param close_on_click Logical; if \code{TRUE}, allows to close toast by clicking on it. Defaults to \code{FALSE}.
#' @param rtl Logical; if \code{TRUE}, applies Right to Left style. Defaults to \code{FALSE}.
#' @param display_mode Rules to show multiple toasts. Default is \code{0}. Valid values are:
#' \itemize{
#' \item \code{0}: Waits until the current toast is closed before displaying a new one.
#' \item \code{1}: Replaces the toast(s) currently displayed with the new toast.
#' \item \code{2}: Replaces only a displayed toast with the same title, message
#'   and text colour. The identity is derived by iziToast.
#' }
#' @param drag_to_close Logical; if \code{TRUE} (the default), toast can be closed by dragging it.
#' @param pause_on_hover Logical; if \code{TRUE} (the default), pauses the toast timeout while the cursor is on it.
#' @param reset_on_hover Logical; if \code{TRUE}, resets the toast timeout while the cursor is on it. Defaults to \code{FALSE}.
#' @param progress_bar_easing Animation easing of progress bar. Defaults to \code{"linear"}.
#' @param overlay Logical; if \code{TRUE}, displays the overlay layer on the page. Defaults to \code{FALSE}.
#' @param overlay_close Logical; if \code{TRUE}, allows to close the toast by clicking on the overlay. Defaults to \code{FALSE}.
#' @param overlay_color Overlay background color. Defaults to \code{"rgba(0, 0, 0, 0.6)"}. Choose between hexadecimal, RGB or keyword values.
#' @param animate_inside Logical; if \code{TRUE} (the default), enables animation of elements in the toast.
#' @param transition_in Toast open animation. Defaults to \code{"fadeInUp"}. Valid values are:
#' \itemize{
#' \item \code{"bounceInLeft"}
#' \item \code{"bounceInRight"}
#' \item \code{"bounceInUp"}
#' \item \code{"bounceInDown"}
#' \item \code{"fadeIn"}
#' \item \code{"fadeInDown"}
#' \item \code{"fadeInUp"}
#' \item \code{"fadeInLeft"}
#' \item \code{"fadeInRight"}
#' \item \code{"flipInX"}
#' \item \code{"revealIn"}
#' \item \code{"slideIn"}
#' }
#' Use \code{NULL} or \code{""} for no open animation.
#' @param transition_out Toast close animation. Defaults to \code{"fadeOut"}. Valid values are:
#' \itemize{
#' \item \code{"fadeOut"}
#' \item \code{"fadeOutDown"}
#' \item \code{"fadeOutUp"}
#' \item \code{"fadeOutLeft"}
#' \item \code{"fadeOutRight"}
#' \item \code{"flipOutX"}
#' }
#' Use \code{NULL} or \code{""} for no close animation.
#' @param session Shiny session object.
#'
#' @section Functions:
#' \itemize{
#' \item \code{useToast}: Dependencies to include in your UI.
#' \item \code{toast}: Display toast notifications.
#' }
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(standby)
#'
#' ui <- fluidPage(
#'
#'   useToast(), # include dependencies
#'   actionButton(inputId = "btn",
#'                label   = "iziToast Demo")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$btn, {
#'     # display toast notification
#'     toast("Hey there!", "Thank you for exploring standby!")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @name toast
#' @return \code{useToast()} returns an HTML dependency to include in the UI.
#'   toast() sends a custom message to the Shiny session for its side effect
#'   and has no meaningful return value.
#'
#' @export
#'
toast <- function(title = "Hey", message = NULL, type = NULL, theme = NULL, position = "center",
                 duration = 5000, progress_bar_color = NULL, background_color = NULL,
                 max_width = NULL, title_color = NULL, title_size = NULL, title_line_height = NULL,
                 message_color = NULL, message_size = NULL, message_line_height = NULL,
                 image = NULL, image_width = "50px", zindex = 99999, layout = 1,
                 balloon = FALSE, close = TRUE, close_on_escape = FALSE, close_on_click = FALSE,
                 rtl = FALSE, display_mode = 0, drag_to_close = TRUE, pause_on_hover = TRUE,
                 reset_on_hover = FALSE, progress_bar_easing = "linear", overlay = FALSE,
                 overlay_close = FALSE, overlay_color = 'rgba(0, 0, 0, 0.6)',
                 animate_inside = TRUE, transition_in = 'fadeInUp', transition_out = 'fadeOut',
                 session = getDefaultReactiveDomain()) {

  # iziToast reads .length on both fields, including in a title-only toast.
  if (is.null(title)) title <- ""
  if (is.null(message)) message <- ""

  type <- validate_choice(type, c("info", "success", "warning", "error", "question"), "type", null = TRUE)
  theme <- validate_class_token(theme, "theme", null = TRUE)
  position <- validate_choice(position, c("bottomRight", "bottomLeft", "topRight", "topLeft",
    "topCenter", "bottomCenter", "center"), "position")
  layout <- validate_choice(layout, c(1, 2, 3), "layout")
  layout <- as.integer(layout)
  if (is_stay_open_delay(duration)) duration <- FALSE
  duration <- normalize_delay(duration, "duration", false = TRUE, null = TRUE)
  transition_in <- validate_choice(transition_in, c("bounceInLeft", "bounceInRight", "bounceInUp",
    "bounceInDown", "fadeIn", "fadeInDown", "fadeInUp", "fadeInLeft",
    "fadeInRight", "flipInX", "revealIn", "slideIn", ""), "transition_in", null = TRUE)
  transition_out <- validate_choice(transition_out, c("fadeOut", "fadeOutDown", "fadeOutUp",
    "fadeOutLeft", "fadeOutRight", "flipOutX", ""), "transition_out", null = TRUE)
  balloon <- validate_flag(balloon, "balloon")
  close <- validate_flag(close, "close")
  close_on_escape <- validate_flag(close_on_escape, "close_on_escape")
  close_on_click <- validate_flag(close_on_click, "close_on_click")
  rtl <- validate_flag(rtl, "rtl")
  drag_to_close <- validate_flag(drag_to_close, "drag_to_close")
  pause_on_hover <- validate_flag(pause_on_hover, "pause_on_hover")
  reset_on_hover <- validate_flag(reset_on_hover, "reset_on_hover")
  overlay <- validate_flag(overlay, "overlay")
  overlay_close <- validate_flag(overlay_close, "overlay_close")
  animate_inside <- validate_flag(animate_inside, "animate_inside")

  # display_mode: 0 queues, 1 replaces, 2 replaces an identical toast.
  if (is.character(display_mode) && length(display_mode) == 1L &&
      !is.na(display_mode) && grepl("^[012]$", trimws(display_mode))) {
    display_mode <- suppressWarnings(as.integer(trimws(display_mode)))
  }
  if (!is.numeric(display_mode) || length(display_mode) != 1L ||
      is.na(display_mode) || !display_mode %in% c(0, 1, 2)) {
    stop("`display_mode` must be one of 0, 1, 2.", call. = FALSE)
  }
  display_mode <- as.integer(display_mode)

  # iziToast appends "px" to unit-less values; normalise on the R side so a
  # number and the documented "50px" both work and never become "50pxpx".
  title_size <- normalize_css_length(title_size, "title_size")
  title_line_height <- normalize_css_length(title_line_height, "title_line_height")
  message_size <- normalize_css_length(message_size, "message_size")
  message_line_height <- normalize_css_length(message_line_height, "message_line_height")
  if (is.null(image_width)) image_width <- "50px"
  image_width <- normalize_css_length(image_width, "image_width")

  notice = list(
    type              = type,
    theme             = theme,
    title             = title,
    titleColor        = title_color,
    titleSize         = title_size,
    titleLineHeight   = title_line_height,
    message           = message,
    messageColor      = message_color,
    messageSize       = message_size,
    messageLineHeight = message_line_height,
    position          = position,
    progressBarColor  = progress_bar_color,
    progressBarEasing = progress_bar_easing,
    backgroundColor   = background_color,
    maxWidth          = max_width,
    image             = image,
    imageWidth        = image_width,
    zindex            = zindex,
    layout            = layout,
    balloon           = balloon,
    close             = close,
    closeOnEscape     = close_on_escape,
    closeOnClick      = close_on_click,
    rtl               = rtl,
    displayMode       = display_mode,
    timeout           = duration,
    drag              = drag_to_close,
    pauseOnHover      = pause_on_hover,
    resetOnHover      = reset_on_hover,
    overlay           = overlay,
    overlayClose      = overlay_close,
    overlayColor      = overlay_color,
    animateInside     = animate_inside,
    transitionIn      = transition_in,
    transitionOut     = transition_out
  )

  session$sendCustomMessage(
    type    = 'toast.send',
    message = notice
  )
}
