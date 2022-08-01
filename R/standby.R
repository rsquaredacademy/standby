#' @export
standby <- function(type = "bouncing") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("dot-", type, " wait")
    )
  )
}
