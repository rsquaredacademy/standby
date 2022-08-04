#' @export
standby <- function(ui_element, type = "bouncing") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("dot-", type, " wait")
    ),
    ui_element
  )
}
