
<!-- README.md is generated from README.Rmd. Please edit that file -->

# standby

<!-- badges: start -->

[![R-CMD-check](https://github.com/rsquaredacademy/standby/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rsquaredacademy/standby/actions/workflows/R-CMD-check.yaml)
[![status](https://tinyverse.netlify.com/badge/standby)](https://CRAN.R-project.org/package=standby)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

Loading screens for Shiny.

## Installation

You can install the development version of standby from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rsquaredacademy/standby")
```

## Usage

Below is a simple example of the package, visit the
[website](https://standby.rsquaredacademy.com) for more.

## Example

``` r
library(shiny)
library(standby)

ui <- fluidPage(

  standby::useSpinkit(), # include dependencies
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

## Inspiration

The following packages served as an inspiration.

-   [shinycssloaders](https://github.com/daattali/shinycssloaders) by
    [Dean Attali](https://attalitech.com/)
-   [waiter](https://github.com/JohnCoene/waiter) by [John
    Coene](https://john-coene.com/)

## Acknowledgements

We referred to the following books extensively while developing standby
and are grateful to the authors for sharing their knowledge with the
R/Shiny community:

-   [Outstanding User Interfaces with
    Shiny](https://unleash-shiny.rinterface.com/index.html) by [David
    Granjon](https://divadnojnarg.github.io/)
-   [JavaScript for R](https://book.javascript-for-r.com/) by [John
    Coene](https://john-coene.com/)

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
