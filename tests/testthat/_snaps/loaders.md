# glanceLoaders() generates the correct HTML

    Code
      glanceLoaders()
    Output
      <div class="standby">
        <div id="loader" class="loader loader-default is-active"></div>
      </div>

# loaders generates the correct HTML

    Code
      loaders(uiOutput = plotOutput("plot"), type = "default", style = "half", text = "Loading...")
    Output
      <div class="standby">
        <div id="loader" class="loader loader-default is-active standby-wait" data-text="Loading..."></div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

