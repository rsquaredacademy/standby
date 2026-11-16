# CSS Loaders

Simple CSS loaders

## Usage

``` r
useLoaders()

loaders(uiOutput, type = "default", style = NULL, text = NULL)
```

## Arguments

- uiOutput:

  An output element to be wrapped within a loader.

- type:

  The type of loader to use. Visit
  <https://css-loader.raphaelfabeni.com/> for details.

  - default

  - bar

  - bar-ping-pong

  - border

  - double

  - clock

  - curtain

  - pokeball

  - ball

  - smartphone

  - bouncing

  - music

- style:

  Custom styling for the loaders.

- text:

  Custom text. Available only for the following types:

  - default

  - bar

  - border

  - curtain

  - smartphone

## Value

`useLoaders()` returns an HTML dependency to include in the UI;
`loaders()` returns a Shiny tag list wrapping `uiOutput`.

## Functions

- `useLoaders`: Dependencies to include in your UI.

- `loaders`: Display loading animation.

## Examples

``` r
if (interactive()) {
  library(shiny)

  shinyApp(
    ui = fluidPage(
      useLoaders(),
      actionButton("render", "Render"),
      loaders(uiOutput = plotOutput("plot"),
              type = "default",
              style = "half",
              text = "Loading...")
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
