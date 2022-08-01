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
    plotOutput("plot"),
    tags$div(
      class = "dot-elastic wait"
    ),
    actionButton("render", "Render")
  )


  
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    input$render
    Sys.sleep(10)
    plot(cars)
  })

}

shinyApp(ui, server)
