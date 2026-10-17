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

  The color of the loader. Choose between hexadecimal, RGB or keyword
  values.

## Value

None

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
