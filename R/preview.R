#' Preview Spinners
#' 
#' Preview different types of spinners/loaders.
#' 
#' @param spinner Type of spinner. The following spinners are available:
#' \itemize{
#' \item threedots
#' \item spinkit
#' \item vizload
#' \item spinners
#' \item loaders
#' }
#' @import htmltools shiny
#' 
#' @export
previewStandby <- function(spinner = "threeDots") {

  dep <- switch(spinner,
                threedots = useThreeDots(),
                spinkit   = useSpinkit(),
                vizload   = useVizLoad(),
                spinners  = useSpinners(),
                loaders   = useLoaders())

  type <- switch(spinner,
                threeDots = glanceThreeDots(),
                spinkit   = glanceSpinkit(),
                vizLoad   = glanceVizLoad(),
                spinners  = glanceSpinners(),
                loaders   = glanceLoaders())              

  htmltools::browsable(
    tagList(
      tags$head(
        dep,
        tags$style(
          "body{background: black;}"
        )
      ),
      div(
        style = "position: relative;height:90vh;",
        div(
          style = "position: absolute;top:50%;left:50%;",
          type
        )
      )
    )
  )

}