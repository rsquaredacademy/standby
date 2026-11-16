# Three Dots

Single element CSS loading animation.

## Usage

``` r
useThreeDots()

threeDots(uiOutput, type = "elastic", color = "#9880ff")
```

## Arguments

- uiOutput:

  An output element to be wrapped within a loader.

- type:

  The type of animation to use. Visit
  <https://nzbin.github.io/three-dots/> for details.

- color:

  The color of the loader. Choose between a color name, hexadecimal, or
  [`rgb()`](https://rdrr.io/r/grDevices/rgb.html)/`rgba()`/`hsl()`/`hsla()`
  values. Names use R's
  [`colors()`](https://rdrr.io/r/grDevices/colors.html) values; CSS
  colour names not in R are also accepted.

## Value

`useThreeDots()` returns an HTML dependency to include in the UI;
`threeDots()` returns a Shiny tag list wrapping `uiOutput`.

## Functions

- `useThreeDots`: Dependencies to include in your UI.

- `threeDots`: Display loading animation.

## Examples

``` r
if (interactive()) {
  library(shiny)

  shinyApp(
    ui = fluidPage(
      useThreeDots(),
      actionButton("render", "Render"),
      threeDots(plotOutput("plot"))
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
