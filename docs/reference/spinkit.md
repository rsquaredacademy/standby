# SpinKit

Simple CSS spinners.

## Usage

``` r
useSpinkit()

spinkit(uiOutput, type = "plane", color = "#333", size = "40px")
```

## Arguments

- uiOutput:

  An output element to be wrapped within a spinner.

- type:

  Type of spinner to use. Valid values are:

  - plane

  - chase

  - bounce

  - wave

  - pulse

  - flow

  - swing

  - circle

  - circle-fade

  - grid

  - fold

  - wander

- color:

  Color of the spinner. Defaults to `"#333"`. Choose between a color
  name, hexadecimal, or
  [`rgb()`](https://rdrr.io/r/grDevices/rgb.html)/`rgba()`/`hsl()`/`hsla()`
  values. Names use R's
  [`colors()`](https://rdrr.io/r/grDevices/colors.html) values; CSS
  colour names not in R are also accepted.

- size:

  Size of the spinner. Defaults to `"40px"`.

## Value

`useSpinkit()` returns an HTML dependency to include in the UI;
`spinkit()` returns a Shiny tag list wrapping `uiOutput`.

## Functions

- `useSpinkit`: Dependencies to include in your UI.

- `spinkit`: Display loading animation.

## Examples

``` r
if (interactive()) {
  library(shiny)

  shinyApp(
    ui = fluidPage(
      useSpinkit(),
      actionButton("render", "Render"),
      spinkit(plotOutput("plot"), type = "circle-fade")
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
