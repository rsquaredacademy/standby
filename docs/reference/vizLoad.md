# Loading Visualization

Loading bars and spinners.

## Usage

``` r
useVizLoad()

vizLoad(
  uiOutput,
  type = "bars",
  size = "large",
  color = NULL,
  add_label = FALSE,
  label = "Loading..."
)
```

## Arguments

- uiOutput:

  An output element to be wrapped within a spinner.

- type:

  The type of bar/spinner to use. Valid values are:

  - bars

  - squares

  - circles

  - dots

  - spinner

  - dashed

  - line

  - bordered_line

- size:

  The size of the bar/spinner. For `"line"` and `"bordered_line"`, valid
  values are `"large"`, `"medium"`, `"small"`, and `"fluid"`. For all
  other types, valid values are `"large"`, `"medium"`, `"small"`, and
  `"tiny"`.

- color:

  The color of the bar/spinner. Choose between a color name,
  hexadecimal, or
  [`rgb()`](https://rdrr.io/r/grDevices/rgb.html)/`rgba()`/`hsl()`/`hsla()`
  values. Names use R's
  [`colors()`](https://rdrr.io/r/grDevices/colors.html) values; CSS
  colour names not in R are also accepted.

- add_label:

  Logical; if `TRUE`, displays a label below the bar/spinner. Defaults
  to `FALSE`.

- label:

  The label to be displayed below the bar/spinner. `add_label` must be
  set to `TRUE` to display the label.

## Value

`useVizLoad()` returns an HTML dependency to include in the UI;
`vizLoad()` returns a Shiny tag list wrapping `uiOutput`.

## Functions

- `useVizLoad`: Dependencies to include in your UI.

- `vizLoad`: Display loading animation.

## Examples

``` r
if (interactive()) {
  library(shiny)

  shinyApp(
    ui = fluidPage(
      useVizLoad(),
      actionButton("render", "Render"),
      vizLoad(plotOutput("plot"))
    ),
    server = function(input, output) {
      output$plot <- renderPlot({
        input$render
        Sys.sleep(3)
        hist(mtcars$mpg)
      })
    }
  )
}
```
