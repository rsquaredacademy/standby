#' @export
#' @import htmltools shiny
previewStandby <- function(standby, bg_color = "black") {

  if(missing(standby))
    stop("Missing standby", call. = FALSE)

  htmltools::browsable(
    tagList(
      tags$head(
        use_three(),
        tags$style(
          paste0("body{background: ", bg_color,";}")
        )
      ),
      div(
        style = "position: relative;height:90vh;",
        div(
          style = "position: absolute;top:50%;left:50%;",
          standby
        )
      )
    )
  )

}
