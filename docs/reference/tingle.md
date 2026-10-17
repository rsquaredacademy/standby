# Tingle

Minimalist and easy to use modals.

## Usage

``` r
useTingle()

tingle(
  content = "Hello",
  close_button = FALSE,
  button_label = "Close",
  button_type = "default",
  button_position = "right",
  session = getDefaultReactiveDomain()
)
```

## Arguments

- content:

  Content of the modal.

- close_button:

  Logical; if `TRUE`, displays a button to close the modal. Defaults to
  `FALSE`.

- button_label:

  Label of `close_button`.

- button_type:

  Type of button. Defaults to `"default"`. Other valid values are:

  - `"primary"`

  - `"danger"`

- button_position:

  Position of the button inside the modal. Defaults to `"right"`. Valid
  values are:

  - `"right"`

  - `"left"`

- session:

  Shiny session object.

## Value

None

## Functions

- `useTingle`: Dependencies to include in your UI.

- `tingle`: Display modals.

## Examples

``` r
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useTingle(), # include dependencies
  actionButton(inputId = "btn",
               label   = "Tingle Demo")

)

server <- function(input, output, session) {

  observeEvent(input$btn, {
    # display modal
    tingle("Hey there!, Thank you for exploring standby!")
  })
}

shinyApp(ui, server)
}
```
