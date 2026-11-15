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
#' @return In an interactive session, a Shiny app object; otherwise
#'   \code{NULL} invisibly.
#' @name preview
#' @export
#'
previewAlerts <- function(type = "toast") {

  type <- match.arg(type, c("alertify", "bootbox", "notice", "notify", "tingle", "toast"))

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
        alertify_alert("Hey there!", "Thank you for exploring standby!")
      } else if (type == "bootbox") {
        bootBox("Hey there!", "Thank you for exploring standby!")
      } else if (type == "notice") {
        notice("Thank you for exploring standby!")
      } else if (type == "notify") {
        notify("Hey there!", "Thank you for exploring standby!")
      } else if (type == "tingle") {
        tingle("Thank you for exploring standby!")
      } else if (type == "toast") {
        toast("Hey there!", "Thank you for exploring standby.")
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
#'
#' @return In an interactive session, browsable HTML; otherwise
#'   \code{NULL} invisibly.
#' @name preview
#'
#' @export
previewSpinners <- function(spinner = "threedots") {

  spinner <- match.arg(spinner, c("threedots", "spinkit", "vizload", "spinners", "loaders"))

  dep <- switch(spinner,
                threedots = useThreeDots(),
                spinkit   = useSpinkit(),
                vizload   = useVizLoad(),
                spinners  = useSpinners(),
                loaders   = useLoaders())

  type <- switch(spinner,
                 threedots = glanceThreeDots(),
                 spinkit   = glanceSpinkit(),
                 vizload   = vizLoad(tags$div(), type = "bars"),
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