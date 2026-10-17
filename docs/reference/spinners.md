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

  Type of spinner to use. Any integer between `1` and `8` is valid.

- color:

  Color of the spinner. Choose between hexadecimal or keyword values.

## Value

None

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
