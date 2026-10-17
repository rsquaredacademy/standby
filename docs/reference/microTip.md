# MicroTip

Minimal CSS only tooltip.

## Usage

``` r
useMicroTip()

microTip(
  id = NULL,
  tip = "Hey! tooltip!",
  position = "top",
  size = NULL,
  session = getDefaultReactiveDomain()
)
```

## Arguments

- id:

  The id of the element to attach the tooltip.

- tip:

  Content of the tooltip.

- position:

  Where the tooltip should appear relative to the target element.
  Defaults to `"top"`. Valid values are:

  - `"top"`

  - `"bottom"`

  - `"left"`

  - `"right"`

  - `"top-left"`

  - `"top-right"`

  - `"bottom-left"`

  - `"bottom-right"`

- size:

  Size of the tooltip. Defaults to `"fit"` as the tooltip will takeup
  only the size it requires to show the text. Valid values are:

  - `"fit"`

  - `"small"`

  - `"medium"`

  - `"large"`

- session:

  Shiny session object.

## Value

None

## Functions

- `useMicroTip`: Dependencies to include in your UI.

- `microTip`: Add tooltip.

## Examples

``` r
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useMicroTip(), # include dependencies
  br(), br(), br(), br(),
  actionButton(inputId = "btn",
               label   = "MicroTip Demo")

)

server <- function(input, output, session) {

  # display tooltip
  microTip(id = "btn",
           tip = "Hey there! This is a micro tip!",
           position = "bottom-right")

}

shinyApp(ui, server)
}
```
