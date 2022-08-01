library(shiny)

addResourcePath('www', 'www')

ui <- fluidPage(
  # import dependencies
  tags$head(
    tags$link(href = "www/three-dots.css", rel = "stylesheet"),
    tags$link(href = "www/style.css", rel = "stylesheet"),
    tags$script(src = "www/script.js")
  ),

  tags$div(
    class = "standby",
    tags$div(
      class = "dot-windmill wait"
    )
  ),

  plotOutput("plot"),
  actionButton("render", "Render")

)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    input$render
    Sys.sleep(10)
    plot(cars)
  })

}

shinyApp(ui, server)
