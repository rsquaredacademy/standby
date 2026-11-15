# Single Element CSS Spinners

A collection of loading spinners animated with CSS

## Usage

``` r
useSpinners()

spinners(uiOutput, type = 1, color = "#0275d8")
```

## Arguments

- uiOutput:

  An output element to be wrapped within a spinner.

- type:

  Type of spinner to use. Any number or string between `1` and `8` (or
  `"1"` and `"8"`) is valid.

- color:

  Color of the spinner. Choose between a color name, hexadecimal, or
  [`rgb()`](https://rdrr.io/r/grDevices/rgb.html)/`rgba()`/`hsl()`/`hsla()`
  values. Names use R's
  [`colors()`](https://rdrr.io/r/grDevices/colors.html) values (so
  `"green"` is `#00FF00`); CSS colour names not in R (such as
  `"rebeccapurple"`) are also accepted.

## Value

`useSpinners()` returns an HTML dependency to include in the UI;
`spinners()` returns a Shiny tag list wrapping `uiOutput`.

## Functions

- `useSpinners`: Dependencies to include in your UI.

- `spinners`: Display loading animation.

## Examples

``` r
if (interactive()) {
  library(shiny)

  shinyApp(
    ui = fluidPage(
      useSpinners(),
      actionButton("render", "Render"),
      spinners(plotOutput("plot"))
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
