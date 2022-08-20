
<!-- README.md is generated from README.Rmd. Please edit that file -->

# standby

<!-- badges: start -->
<!-- badges: end -->

Loading screens for Shiny.

## Installation

You can install the development version of standby from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aravindhebbali/standby")
```

## Usage

Below is a simple example of the package, visit the
[website](https://buzz.rsquaredacademy.com) for more.

## Example

``` r
library(shiny)
library(standby)

ui <- fluidPage(

  stanby::useSpinkit(), # include dependencies
  fluidRow(
    standby::spinkit(plotOutput("plot1")), # wrap output inside loader
    actionButton("render", "Render")
  )

)

server <- function(input, output, session) {

    output$plot1 <- renderPlot({
      input$render
      Sys.sleep(3)
      plot(cars)
    })

}

shinyApp(ui, server)
```

## Details

**standby** offers several types of loaders/spinners. Visit the below
websites to learn more:

-   [Three Dots](https://github.com/nzbin/three-dots)
-   [SpinKit](https://github.com/tobiasahlin/SpinKit)
-   [Loading
    Visualization](https://github.com/RIDICS/Loading-Visualization)
-   [CSS Spinners](https://github.com/lukehaas/css-loaders)
-   [CSS Loaders](https://github.com/raphaelfabeni/css-loader)

## Getting Help

If you encounter a bug, please file a minimal reproducible example using
[reprex](https://reprex.tidyverse.org/index.html) on github. For
questions and clarifications, use
[StackOverflow](https://stackoverflow.com/).

## Code of Conduct

Please note that the standby project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.