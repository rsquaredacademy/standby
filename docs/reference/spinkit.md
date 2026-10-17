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

  Color of the spinner. Defaults to `"#333"`. Choose between
  hexadecimal, RGB or keyword values.

- size:

  Size of the spinner. Defaults to `"40px"`.

## Value

None

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
