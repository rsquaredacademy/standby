#' @export
#' @import htmltools shiny
previewStandby <- function(glance, bg_color = "black") {

  if(missing(glance))
    stop("Missing standby", call. = FALSE)

  htmltools::browsable(
    tagList(
      tags$head(
        useThreeDots(),
        tags$style(
          paste0("body{background: ", bg_color,";}")
        )
      ),
      div(
        style = "position: relative;height:90vh;",
        div(
          style = "position: absolute;top:50%;left:50%;",
          glance
        )
      )
    )
  )

}

#' @export
previewSpinkit <- function(glance, bg_color = "black") {

  if(missing(glance))
    stop("Missing glance", call. = FALSE)

  htmltools::browsable(
    tagList(
      tags$head(
        useSpinkit(),
        tags$style(
          paste0("body{background: ", bg_color,";}")
        )
      ),
      div(
        style = "position: relative;height:90vh;",
        div(
          style = "position: absolute;top:50%;left:50%;",
          glance
        )
      )
    )
  )

}

#' @export
previewVizLoad <- function(glance, bg_color = "black") {

  if(missing(glance))
    stop("Missing glance", call. = FALSE)

  htmltools::browsable(
    tagList(
      tags$head(
        useVizLoad(),
        tags$style(
          paste0("body{background: ", bg_color,";}")
        )
      ),
      div(
        style = "position: relative;height:90vh;",
        div(
          style = "position: absolute;top:50%;left:50%;transform:translate(-50%, -50%)",
          glance
        )
      )
    )
  )

}
