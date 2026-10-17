# standby

Easily create alerts, notifications, tooltips and loading screens in
Shiny

## Installation

`# Install release version from CRAN`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"standby"``)`` `` ``# Install development version from GitHub`` ``# install.packages("devtools")`` ``devtools``::`[`install_github`](https://devtools.r-lib.org/reference/install-deprecated.html)`(``"rsquaredacademy/standby"``)`

## Usage

### Loading Screens

To use spinners/loaders from **standby** in your Shiny application,
include the following in the **UI** part of the app:

- Include the dependencies using the appropriate `use*` functions
  ([`useSpinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md)
  in the below example).
- Wrap the target output using corresponding rendering function
  ([`spinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md)
  in the below example).

##### Example

[`library`](https://rdrr.io/r/base/library.html)`(`[`shiny`](https://shiny.posit.co/)`)`` `[`library`](https://rdrr.io/r/base/library.html)`(`[`standby`](https://standby.rsquaredacademy.com/)`)`` `` ``ui`` ``<-`` `[`fluidPage`](https://rdrr.io/pkg/shiny/man/fluidPage.html)`(`` `` `` ``standby``::`[`useSpinkit`](https://standby.rsquaredacademy.com/reference/spinkit.md)`(``)``, ``# include dependencies`` `` `[`fluidRow`](https://rdrr.io/pkg/shiny/man/fluidPage.html)`(`` `` ``standby``::`[`spinkit`](https://standby.rsquaredacademy.com/reference/spinkit.md)`(`[`plotOutput`](https://rdrr.io/pkg/shiny/man/plotOutput.html)`(``"plot1"``)``)``, ``# wrap output inside loader`` `` `[`actionButton`](https://rdrr.io/pkg/shiny/man/actionButton.html)`(``"render"``, ``"Render"``)`` `` ``)`` `` ``)`` `` ``server`` ``<-`` ``function``(``input``, ``output``, ``session``)`` ``{`` `` `` ``output``$``plot1`` ``<-`` `[`renderPlot`](https://rdrr.io/pkg/shiny/man/renderPlot.html)`(``{`` `` ``input``$``render`` `` `[`Sys.sleep`](https://rdrr.io/r/base/Sys.sleep.html)`(``3``)`` `` `[`hist`](https://rdrr.io/r/graphics/hist.html)`(``mtcars``$``mpg``)`` `` ``}``)`` `` ``}`` `` `[`shinyApp`](https://rdrr.io/pkg/shiny/man/shinyApp.html)`(``ui``, ``server``)`

#### Details

The below table displays the dependency and rendering functions along
with references:

| Index | Dependency | Render | Reference |
|----|----|----|----|
| 1 | [`useThreeDots()`](https://standby.rsquaredacademy.com/reference/threeDots.md) | [`threeDots()`](https://standby.rsquaredacademy.com/reference/threeDots.md) | [Three Dots](https://github.com/nzbin/three-dots) |
| 2 | [`useSpinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md) | [`spinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md) | [SpinKit](https://github.com/tobiasahlin/SpinKit) |
| 3 | [`useVizLoad()`](https://standby.rsquaredacademy.com/reference/vizLoad.md) | [`vizLoad()`](https://standby.rsquaredacademy.com/reference/vizLoad.md) | [Loading Visualization](https://github.com/RIDICS/Loading-Visualization) |
| 4 | [`useSpinners()`](https://standby.rsquaredacademy.com/reference/spinners.md) | [`spinners()`](https://standby.rsquaredacademy.com/reference/spinners.md) | [Spinners](https://github.com/lukehaas/css-loaders) |
| 5 | [`useLoaders()`](https://standby.rsquaredacademy.com/reference/loaders.md) | [`loaders()`](https://standby.rsquaredacademy.com/reference/loaders.md) | [Loaders](https://github.com/raphaelfabeni/css-loader) |

### Alerts and Notifications

To use alerts or notifications from **buzz** in your Shiny application,
follow the below steps:

- Include the dependencies in the **UI** part of the app using the
  appropriate `use*` functions
  ([`useToast()`](https://standby.rsquaredacademy.com/reference/toast.md)
  in the below example).
- Include the corresponding rendering function in the **Server** part of
  the app
  ([`toast()`](https://standby.rsquaredacademy.com/reference/toast.md)
  in the below example).

##### Example

[`library`](https://rdrr.io/r/base/library.html)`(`[`shiny`](https://shiny.posit.co/)`)`` `[`library`](https://rdrr.io/r/base/library.html)`(`[`standby`](https://standby.rsquaredacademy.com/)`)`` ``ui`` ``<-`` `[`fluidPage`](https://rdrr.io/pkg/shiny/man/fluidPage.html)`(`` `` `[`useBootBox`](https://standby.rsquaredacademy.com/reference/bootBox.md)`(``)``, ``# include dependencies`` `` `[`actionButton`](https://rdrr.io/pkg/shiny/man/actionButton.html)`(``inputId ``=`` ``"notify"``,`` `` label ``=`` ``"Show Notification"``)`` ``)`` ``server`` ``<-`` ``function``(``input``, ``output``, ``session``)`` ``{`` `` `[`observeEvent`](https://rdrr.io/pkg/shiny/man/observeEvent.html)`(``input``$``pnotify``, ``{`` `` `[`bootBox`](https://standby.rsquaredacademy.com/reference/bootBox.md)`(``class ``=`` ``"rubberBand"``)`` ``# display the alert`` `` ``}``)`` ``}`` `[`shinyApp`](https://rdrr.io/pkg/shiny/man/shinyApp.html)`(``ui``, ``server``)`

#### Details

The below table displays the dependency and rendering functions along
with references:

| Index | Dependency | Render | Reference |
|----|----|----|----|
| 1 | [`useAlertify()`](https://standby.rsquaredacademy.com/reference/alertify.md) | [`alertify_alert()`](https://standby.rsquaredacademy.com/reference/alertify.md) | [Alertify](https://github.com/MohammadYounes/AlertifyJS) |
| 2 | [`useAlertify()`](https://standby.rsquaredacademy.com/reference/alertify.md) | [`alertify_notify()`](https://standby.rsquaredacademy.com/reference/alertify.md) | [Alertify](https://github.com/MohammadYounes/AlertifyJS) |
| 3 | [`useBootBox()`](https://standby.rsquaredacademy.com/reference/bootBox.md) | [`bootBox()`](https://standby.rsquaredacademy.com/reference/bootBox.md) | [BootBox](https://github.com/bootboxjs/bootbox) |
| 4 | [`useMicroTip()`](https://standby.rsquaredacademy.com/reference/microTip.md) | [`microTip()`](https://standby.rsquaredacademy.com/reference/microTip.md) | [MicroTip](https://github.com/ghosh/microtip) |
| 5 | [`useNS()`](https://standby.rsquaredacademy.com/reference/notice.md) | [`notice()`](https://standby.rsquaredacademy.com/reference/notice.md) | [Notification Styles](https://tympanus.net/Development/NotificationStyles/) |
| 6 | [`useNotify()`](https://standby.rsquaredacademy.com/reference/notify.md) | [`notify()`](https://standby.rsquaredacademy.com/reference/notify.md) | [PNotify](https://github.com/sciactive/pnotify) |
| 7 | [`useTingle()`](https://standby.rsquaredacademy.com/reference/tingle.md) | [`tingle()`](https://standby.rsquaredacademy.com/reference/tingle.md) | [Tingle](https://github.com/robinparisi/tingle) |
| 8 | [`useToast()`](https://standby.rsquaredacademy.com/reference/toast.md) | [`toast()`](https://standby.rsquaredacademy.com/reference/toast.md) | [iziToast](https://github.com/marcelodolza/iziToast) |

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
