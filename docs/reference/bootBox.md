# BootBox

Bootstrap modals made easy.

## Usage

``` r
useBootBox()

bootBox(
  title = "Your title",
  message = "Your message here...",
  size = "small",
  close_on_escape = TRUE,
  show = TRUE,
  backdrop = NULL,
  close_button = TRUE,
  animate = TRUE,
  class = NULL,
  session = getDefaultReactiveDomain()
)
```

## Arguments

- title:

  Adds a header to the dialog.

- message:

  Text displayed in the dialog.

- size:

  Adds the relevant Bootstrap modal size class to the dialog wrapper.
  Valid values are:

  - `"small"`

  - `"large"`

  - `"extra-large"`

- close_on_escape:

  Logical; if `TRUE` (the default), allows the user to dismiss the
  dialog by hitting `ESC` key.

- show:

  Logical; if `TRUE` (the default), the dialog is shown immediately.

- backdrop:

  Logical; if `TRUE`, the backdrop is displayed and clicking on it
  dismisses the dialog. Defaults to `NULL`. Valid values are:

  - `NULL`: The backdrop is displayed, but clicking on it has no effect.

  - `TRUE`: The backdrop is displayed, and clicking on it dismisses the
    dialog.

  - `FALSE`: The backdrop is not displayed.

- close_button:

  Logical; if `TRUE` (the default), a close button is displayed.

- animate:

  Logical; if `TRUE` (the default), animates the dialog in and out.

- class:

  Custom CSS class (using Animate.css).

- session:

  Shiny session object.

## Value

None

## Functions

- `useBootBox`: Dependencies to include in your UI.

- `bootBox`: Display modals.

## Examples

``` r
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useBootBox(), # include dependencies
  actionButton(inputId = "btn",
               label   = "BootBox Demo")

)

server <- function(input, output, session) {

  observeEvent(input$btn, {
    # display modal
    bootBox("Hey there!", "Thank you for exploring standby!")
  })
}

shinyApp(ui, server)
}
```
