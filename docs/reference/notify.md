# PNotify

Beautiful notifications and prompts.

## Usage

``` r
useNotify()

notify(
  title = "Hey",
  text = NULL,
  type = "notice",
  icon = TRUE,
  delay = 8000,
  hide = TRUE,
  sticker = TRUE,
  closer = TRUE,
  shadow = TRUE,
  mouse_reset = TRUE,
  animation = "fade",
  animate_speed = "normal",
  width = "360px",
  min_height = "16px",
  max_text_height = "200px",
  translucent = FALSE,
  non_blocking = FALSE,
  session = getDefaultReactiveDomain()
)
```

## Arguments

- title:

  Title of the notice. It can be a string, an element or `FALSE` (the
  default) for no title.

- text:

  Text of the notice. It can be a string, an element or `FALSE` (the
  default) for no text.

- type:

  Type of notice. Defaults to `"notice"`. Other valid values are:

  - `"info"`

  - `"success"`

  - `"error"`

- icon:

  Logical; if `TRUE` (the default), default icon is displayed. No icon
  is displayed if set to `FALSE`.

- delay:

  Delay in milliseconds before the notice is removed. If set to
  `"infinity"`, the notice will not close.

- hide:

  Logical; if `TRUE` (the default), notice is closed after `delay`
  specified in milliseconds.

- sticker:

  Logical; if `TRUE` (the default), provides a button for the user to
  manually stick the notice.

- closer:

  Logical; if `TRUE` (the default), provides a button for the user to
  manually close the notice.

- shadow:

  Logical; if `TRUE` (the default), displays a drop shadow.

- mouse_reset:

  Logical; if `TRUE` (the default), resets the hide timer if the mouse
  moves over the notice.

- animation:

  The animation to be used while displaying and hiding the notice.
  `"none"` and `"fade"` (the default) are supported out of the box.

- animate_speed:

  Speed at which the notice animates in and out. Valid values are:

  - `"slow"`: 400ms

  - `"normal"`: 250ms

  - `"fast"`: 100ms

- width:

  Width of the notice. Default is `"360px"`.

- min_height:

  Minimum height of the notice. Default is `"16px"`. It will expand to
  fit the content.

- max_text_height:

  Maximum height of the text container. Default is `"200px"`. If the
  text goes beyond this height, scrollbars will appear. Use `NULL` to
  remove this restriction.

- translucent:

  Logical; if `TRUE`, creates see through notice. Defaults to `FALSE`.

- non_blocking:

  Logical; if `TRUE`, notice fades to show elements underneath. Defaults
  to `FALSE`.

- session:

  Shiny session object.

## Value

None

## Functions

- `useNotify`: Dependencies to include in your UI.

- `notify`: Display notifications.

## Examples

``` r
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useNotify(), # include dependencies
  actionButton(inputId = "btn",
               label   = "PNotify Demo")

)

server <- function(input, output, session) {

  observeEvent(input$btn, {
    # display notification
    notify("Hey there!", "Thank you for exploring standby!")
  })
}

shinyApp(ui, server)
}
```
