
<!-- README.md is generated from README.Rmd. Please edit that file -->

# standby

<!-- badges: start -->

[![R-CMD-check](https://github.com/rsquaredacademy/standby/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rsquaredacademy/standby/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![Codecov test
coverage](https://codecov.io/gh/rsquaredacademy/standby/branch/master/graph/badge.svg)](https://app.codecov.io/gh/rsquaredacademy/standby?branch=master)
<!-- badges: end -->

Easily create alerts, notifications, tooltips and loading screens in
Shiny

## Installation

You can install the development version of standby from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rsquaredacademy/standby")
```

## Usage

### Loading Screens

To use spinners/loaders from **standby** in your Shiny application,
include the following in the **UI** part of the app:

- Include the dependencies using the appropriate `use*` functions
  (`useSpinkit()` in the below example).
- Wrap the target output using corresponding rendering function
  (`spinkit()` in the below example).

##### Example

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

#### Details

The below table displays the dependency and rendering functions along
with references:

| Index | Dependency       | Render        | Reference                                                                |
|-------|------------------|---------------|--------------------------------------------------------------------------|
| 1     | `useThreeDots()` | `threeDots()` | [Three Dots](https://github.com/nzbin/three-dots)                        |
| 2     | `useSpinkit()`   | `spinkit()`   | [SpinKit](https://github.com/tobiasahlin/SpinKit)                        |
| 3     | `useVizLoad()`   | `vizLoad()`   | [Loading Visualization](https://github.com/RIDICS/Loading-Visualization) |
| 4     | `useSpinners()`  | `spinners()`  | [Spinners](https://github.com/lukehaas/css-loaders)                      |
| 5     | `useLoaders()`   | `loaders()`   | [Loaders](https://github.com/raphaelfabeni/css-loader)                   |

### Alerts and Notifications

To use alerts or notifications from **buzz** in your Shiny application,
follow the below steps:

- Include the dependencies in the **UI** part of the app using the
  appropriate `use*` functions (`useToast()` in the below example).
- Include the corresponding rendering function in the **Server** part of
  the app (`toast()` in the below example).

##### Example

``` r
library(shiny)
library(standby)
ui <- fluidPage(
  useBootBox(), # include dependencies
  actionButton(inputId = "notify",
               label   = "Show Notification")
)
server <- function(input, output, session) {
  observeEvent(input$pnotify, {
    bootBox(class = "rubberBand") # display the alert
  })
}
shinyApp(ui, server)
```

#### Details

The below table displays the dependency and rendering functions along
with references:

| Index | Dependency      | Render              | Reference                                                                   |
|-------|-----------------|---------------------|-----------------------------------------------------------------------------|
| 1     | `useAlertify()` | `alertify_alert()`  | [Alertify](https://github.com/MohammadYounes/AlertifyJS)                    |
| 2     | `useAlertify()` | `alertify_notify()` | [Alertify](https://github.com/MohammadYounes/AlertifyJS)                    |
| 3     | `useBootBox()`  | `bootBox()`         | [BootBox](https://github.com/bootboxjs/bootbox)                             |
| 4     | `useMicroTip()` | `microTip()`        | [MicroTip](https://github.com/ghosh/microtip)                               |
| 5     | `useNS()`       | `notice()`          | [Notification Styles](https://tympanus.net/Development/NotificationStyles/) |
| 6     | `useNotify()`   | `notify()`          | [PNotify](https://github.com/sciactive/pnotify)                             |
| 7     | `useTingle()`   | `tingle()`          | [Tingle](https://github.com/robinparisi/tingle)                             |
| 8     | `useToast()`    | `toast()`           | [iziToast](https://github.com/marcelodolza/iziToast)                        |

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
