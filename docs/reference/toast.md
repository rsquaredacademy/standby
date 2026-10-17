# iziToast

Lightweight toast notifications

## Usage

``` r
useToast()

toast(
  title = "Hey",
  message = NULL,
  type = NULL,
  theme = NULL,
  position = "center",
  duration = 5000,
  progress_bar_color = NULL,
  background_color = NULL,
  max_width = NULL,
  title_color = NULL,
  title_size = NULL,
  title_line_height = NULL,
  message_color = NULL,
  message_size = NULL,
  message_line_height = NULL,
  image = NULL,
  image_width = NULL,
  zindex = 99999,
  layout = 1,
  balloon = FALSE,
  close = TRUE,
  close_on_escape = FALSE,
  close_on_click = FALSE,
  rtl = FALSE,
  display_mode = 0,
  drag_to_close = TRUE,
  pause_on_hover = TRUE,
  reset_on_hover = FALSE,
  progress_bar_easing = "linear",
  overlay = FALSE,
  overlay_close = FALSE,
  overlay_color = "rgba(0, 0, 0, 0.6)",
  animate_inside = TRUE,
  transition_in = "fadeInUp",
  transition_out = "fadeOut",
  session = getDefaultReactiveDomain()
)
```

## Arguments

- title:

  Title of the toast.

- message:

  Message of toast.

- type:

  Type of notification. Defaults to `NULL`. Valid values are:

  - `"info"`

  - `"success"`

  - `"warning"`

  - `"error"`

- theme:

  Theme of toast. Choose between `"light"` or `"dark"`.

- position:

  Where toast will be shown. Defaults to `"bottomRight"`. Valid values
  are:

  - `"bottomRight"`

  - `"bottomLeft"`

  - `"topRight"`

  - `"topLeft"`

  - `"topCenter"`

  - `"bottomCenter"`

  - `"center"`

- duration:

  Time in milliseconds to close the toast. Defaults to `5000`. Use
  `FALSE` to disable.

- progress_bar_color:

  Progress bar color. Choose between hexadecimal, RGB or keyword values.

- background_color:

  Background color of the toast. Choose between hexadecimal, RGB or
  keyword values.

- max_width:

  Maximum width of the toast.

- title_color:

  Title color. Choose between hexadecimal, RGB or keyword values.

- title_size:

  Title font size.

- title_line_height:

  Title line height.

- message_color:

  Message color. Choose between hexadecimal, RGB or keyword values.

- message_size:

  Message font size.

- message_line_height:

  Message line height.

- image:

  Cover image.

- image_width:

  Width of cover image. Defaults to `"50px"`.

- zindex:

  The z-index CSS attribute of the toast. Defaults to `99999`.

- layout:

  Size of the toast. Choose between `1` or `2`.

- balloon:

  Logical; if `TRUE`, applies a balloon like toast. Defaults to `FALSE`.

- close:

  Logical; if `TRUE` (the default), shows a `x` close button.

- close_on_escape:

  Logical; if `TRUE`, allows to close toast using ESC key. Defaults to
  `FALSE`.

- close_on_click:

  Logical; if `TRUE`, allows to close toast by clicking on it. Defaults
  to `FALSE`.

- rtl:

  Logical; if `TRUE`, applies Right to Left style. Defaults to `FALSE`.

- display_mode:

  Rules to show multiple toasts. Default is `0`. Valid values are:

  - `0`: Waits until the current toast is closed before displaying a new
    one.

  - `1`: Replaces the current toast with the new toast toast.

- drag_to_close:

  Logical; if `TRUE` (the default), toast can be closed by dragging it.

- pause_on_hover:

  Logical; if `TRUE` (the default), pauses the toast timeout while the
  cursor is on it.

- reset_on_hover:

  Logical; if `TRUE`, resets the toast timeout while the cursor is on
  it. Defaults to `FALSE`.

- progress_bar_easing:

  Animation easing of progress bar. Defaults to `"linear"`.

- overlay:

  Logical; if `TRUE`, displays the overlay layer on the page. Defaults
  to `FALSE`.

- overlay_close:

  Logical; if `TRUE`, allows to close the toast by clicking on the
  overlay. Defaults to `FALSE`.

- overlay_color:

  Overlay background color. Defaults to `"rgba(0, 0, 0, 0.6)"`. Choose
  between hexadecimal, RGB or keyword values.

- animate_inside:

  Logical; if `TRUE` (the default), enables animation of elements in the
  toast.

- transition_in:

  Toast open animation. Defaults to `"fadeInUp"`. Valid values are:

  - `"bounceInLeft"`

  - `"bounceInRight"`

  - `"bounceInUp"`

  - `"bounceInDown"`

  - `"fadeIn"`

  - `"fadeInDown"`

  - `"fadeInUp"`

  - `"fadeInLeft"`

  - `"fadeInRight"`

  - `"flipInX"`

- transition_out:

  Toast close animation. Defaults to `"fadeOut"`. Valid values are:

  - `"fadeOut"`

  - `"fadeOutDown"`

  - `"fadeOutUp"`

  - `"fadeOutLeft"`

  - `"fadeOutRight"`

  - `"flipOutX"`

- session:

  Shiny session object.

## Value

None

## Functions

- `useToast`: Dependencies to include in your UI.

- `toast`: Display toast notifications.

## Examples

``` r
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useToast(), # include dependencies
  actionButton(inputId = "btn",
               label   = "iziToast Demo")

)

server <- function(input, output, session) {

  observeEvent(input$btn, {
    # display toast notification
    toast("Hey there!", "Thank you for exploring standby!")
  })
}

shinyApp(ui, server)
}
```
