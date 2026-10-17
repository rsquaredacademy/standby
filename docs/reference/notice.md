# Notification Styles

Simple website notifications with effects

## Usage

``` r
useNS()

notice(
  message = "Hello",
  type = "notice",
  layout = "growl",
  effect = "jelly",
  session = getDefaultReactiveDomain()
)
```

## Arguments

- message:

  Notification message.

- type:

  Notification type. Defaults to `"notice"`. Other valid values are:

  - `"success"`

  - `"warning"`

  - `"error"`

- layout:

  Notification layout. Defaults to `"growl"`. Other valid values are:

  - `"attached"`

  - `"bar"`

- effect:

  Notification effect type. Valid values include:

  - For `"growl"` layout

    - `"scale"`

    - `"jelly"`

    - `"slide"`

    - `"genie"`

  - For`"attached"` layout

    - `"flip"`

    - `"bouncyflip"`

  - For `"bar"` layout

    - `"slidetop"`

    - `"exploader"`

- session:

  Shiny session object.

## Value

None

## Functions

- `useNS`: Dependencies to include in your UI.

- `notice`: Display notifications.

## Examples

``` r
if (interactive()) {
library(shiny)
library(standby)

ui <- fluidPage(

  useNS(), # include dependencies
  actionButton(inputId = "btn",
               label   = "Notice Demo")

)

server <- function(input, output, session) {

  observeEvent(input$btn, {
    # display notification
    notice("Hey there! Thank you for exploring standby!")
  })
}

shinyApp(ui, server)
}
```
