# Loading Screens

standby offers several types of loading screens for Shiny apps. This
document is a quickstart guide for using standby in your Shiny
applications. Let us look at a simple example below:

[`library`](https://rdrr.io/r/base/library.html)`(`[`shiny`](https://shiny.posit.co/)`)`` `[`library`](https://rdrr.io/r/base/library.html)`(`[`standby`](https://standby.rsquaredacademy.com/)`)`` `` ``ui`` ``<-`` `[`fluidPage`](https://rdrr.io/pkg/shiny/man/fluidPage.html)`(`` `` `` ``standby``::`[`useSpinkit`](https://standby.rsquaredacademy.com/reference/spinkit.md)`(``)``, ``# include dependencies`` `` `[`fluidRow`](https://rdrr.io/pkg/shiny/man/fluidPage.html)`(`` `` ``standby``::`[`spinkit`](https://standby.rsquaredacademy.com/reference/spinkit.md)`(`[`plotOutput`](https://rdrr.io/pkg/shiny/man/plotOutput.html)`(``"plot1"``)``)``, ``# wrap output inside loader`` `` `[`actionButton`](https://rdrr.io/pkg/shiny/man/actionButton.html)`(``"render"``, ``"Render"``)`` `` ``)`` `` ``)`` `` ``server`` ``<-`` ``function``(``input``, ``output``, ``session``)`` ``{`` `` `` ``output``$``plot1`` ``<-`` `[`renderPlot`](https://rdrr.io/pkg/shiny/man/renderPlot.html)`(``{`` `` ``input``$``render`` `` `[`Sys.sleep`](https://rdrr.io/r/base/Sys.sleep.html)`(``3``)`` `` `[`hist`](https://rdrr.io/r/graphics/hist.html)`(``mtcars``$``mpg``)`` `` ``}``)`` `` ``}`` `` `[`shinyApp`](https://rdrr.io/pkg/shiny/man/shinyApp.html)`(``ui``, ``server``)`

To use spinners/loaders from **standby** in your Shiny application,
include the following in the **UI** part of the app:

- Include the dependencies using the appropriate `use*` functions
  ([`useSpinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md)
  in the above example).
- Wrap the target output using corresponding rendering function
  ([`spinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md)
  in the above example).

The below table displays the dependency and rendering functions along
with references:

| Index | Dependency | Render | Reference |
|---:|:---|:---|:---|
| 1 | [`useThreeDots()`](https://standby.rsquaredacademy.com/reference/threeDots.md) | [`threeDots()`](https://standby.rsquaredacademy.com/reference/threeDots.md) | <https://github.com/nzbin/three-dots> |
| 2 | [`useSpinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md) | [`spinkit()`](https://standby.rsquaredacademy.com/reference/spinkit.md) | <https://github.com/tobiasahlin/SpinKit> |
| 3 | [`useVizLoad()`](https://standby.rsquaredacademy.com/reference/vizLoad.md) | [`vizLoad()`](https://standby.rsquaredacademy.com/reference/vizLoad.md) | <https://github.com/RIDICS/Loading-Visualization> |
| 4 | [`useSpinners()`](https://standby.rsquaredacademy.com/reference/spinners.md) | [`spinners()`](https://standby.rsquaredacademy.com/reference/spinners.md) | <https://github.com/lukehaas/css-loaders> |
| 5 | [`useLoaders()`](https://standby.rsquaredacademy.com/reference/loaders.md) | [`loaders()`](https://standby.rsquaredacademy.com/reference/loaders.md) | <https://github.com/raphaelfabeni/css-loader> |

Visit the [documentation](https://standby.rsquaredacademy.com) to learn
how to customize the alerts and notifications.
