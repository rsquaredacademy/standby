#' Preview Alerts
#'
#' Preview different types of alerts/notifications.
#'
#' @param type Type of alert/notification. Valid values are:
#' \itemize{
#' \item alertify
#' \item bootbox
#' \item notice
#' \item notify
#' \item tingle
#' \item toast
#' }
#'
#' @return None
#' @export
#'
previewBuzz <- function(type = "toast") {

  dep <- switch(type,
                "alertify" = useAlertify(),
                "bootbox"  = useBootBox(),
                "notice"   = useNS(),
                "notify"   = useNotify(),
                "tingle"   = useTingle(),
                "toast"    = useToast())

  if (interactive()) {

    ui <- fluidPage(
      dep
    )

    server <- function(input, output, session) {

      if (type == "alertify") {
        alertify_alert("Hey there!", "Thank you for exploring buzz!")
      } else if (type == "bootbox") {
        bootBox("Hey there!", "Thank you for exploring buzz!")
      } else if (type == "notice") {
        notice("Thank you for exploring buzz!")
      } else if (type == "notify") {
        notify("Hey there!", "Thank you for exploring buzz!")
      } else if (type == "tingle") {
        tingle("Thank you for exploring buzz!")
      } else if (type == "toast") {
        toast("Hey there!", "Thank you for exploring buzz.")
      }

    }

    shinyApp(ui, server)
  }
}

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
#' @return None
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

  if (interactive()) {
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

}