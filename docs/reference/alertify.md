# Alertify

Pretty browser alerts and notifications.

## Usage

``` r
useAlertify()

alertify_alert(
  title = "Alert Title",
  message = "Alert Message",
  type = "success",
  btn_label = "OK",
  transition = "pulse",
  transition_off = FALSE,
  closable = TRUE,
  auto_reset = FALSE,
  frameless = FALSE,
  maximizable = FALSE,
  modal = FALSE,
  movable = FALSE,
  move_bounded = TRUE,
  overflow = FALSE,
  padding = TRUE,
  pinnable = FALSE,
  resizeable = FALSE,
  start_maximized = FALSE,
  session = getDefaultReactiveDomain()
)

alertify_notify(
  message = "Alert Message",
  type = "success",
  delay = 5,
  position = "bottom-right",
  session = getDefaultReactiveDomain()
)
```

## Arguments

- title:

  Dialog title.

- message:

  Dialog contents.

- type:

  Dialog type. Defaults to `"success"`. Valid values are:

  - `"success"`

  - `"error"`

  - `"warning"`

  - `"message"`

- btn_label:

  The `OK` button label.

- transition:

  Transition effect to be used when showing/hiding the dialog. Defaults
  to `"pulse"`. Valid values are:

  - `"pulse"`

  - `"slide"`

  - `"zoom"`

  - `"fade"`

  - `"flipx"`

  - `"flipy"`

- transition_off:

  Logical; if `TRUE`, transition effect is disabled. Defaults to
  `FALSE`.

- closable:

  Logical; if `TRUE` (the default), a `Close` button is displayed in the
  header of the dialog.

- auto_reset:

  Logical; if `TRUE` (the default), the dialog will reset size/position
  on window resize.

- frameless:

  Logical; if `TRUE`, hides both header and footer of the dialog.
  Defaults to `FALSE`.

- maximizable:

  Logical; if `TRUE` (the default), the `Maximize` button is displayed
  in the header of the dialog.

- modal:

  Logical; if `TRUE` (the default), a screen dimmer will be used and
  access to the page contents will be prevented.

- movable:

  Logical; if `TRUE` (the default), the dialog is movable.

- move_bounded:

  Logical; if `TRUE`, the dialog is not allowed to go off-screen.
  Defaults to `FALSE`.

- overflow:

  Logical; if `TRUE` (the default), the content overflow is managed by
  the dialog

- padding:

  Logical; if `TRUE` (the default), the content padding is managed by
  the dialog.

- pinnable:

  Logical; if `TRUE` (the default), the `Pin` button is displayed in the
  header of the dialog.

- resizeable:

  Logical; if `TRUE`, the dialog is resizable. Defaults to `FALSE`.

- start_maximized:

  Logical; if `TRUE`, the dialog will start in a maximized state.
  Defaults to `FALSE`.

- session:

  Shiny session object.

- delay:

  The time (in seconds) to wait before the notification is
  auto-dismissed. `0` will keep notification open till clicked.

- position:

  Position of the notification. Defaults to `"bottom-right"`. Valid
  values are:

  - `"bottom-right"`

  - `"bottom-left"`

  - `"bottom-center"`

  - `"top-right"`

  - `"top-left"`

  - `"top-center"`

## Value

None

## Functions

- `useAlertify`: Dependencies to include in your UI.

- `alertify_alert`: Display alerts.

- `alertify_notify`: Display notifications.

## Examples

``` r

# Example 1: Alert
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useAlertify(), # include dependencies
  actionButton(inputId = "btn",
               label   = "Alert Demo")

)

server <- function(input, output, session) {

  observeEvent(input$btn, {
    # display alert
    alertify_alert("Hey there!", "Thank you for exploring standby!")
  })
}

shinyApp(ui, server)
}

# Example 2: Notification
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useAlertify(), # include dependencies
  actionButton(inputId = "btn",
               label   = "Notification Demo")

)

server <- function(input, output, session) {

  observeEvent(input$btn, {
    # display notification
    alertify_notify("Hey there! Thank you for exploring standby!")
  })
}

shinyApp(ui, server)
}
```
