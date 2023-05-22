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

# loaders generates the correct HTML when style is blink

    Code
      loaders(uiOutput = plotOutput("plot"), type = "default", style = "blink")
    Output
      <div class="standby">
        <div id="loader" class="loader loader-default is-active standby-wait" data-text data-blink></div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# loaders generates the correct HTML when style is inverse

    Code
      loaders(uiOutput = plotOutput("plot"), type = "default", style = "inverse")
    Output
      <div class="standby">
        <div id="loader" class="loader loader-default is-active standby-wait" data-inverse></div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# loaders generates the correct HTML when type is curtain

    Code
      loaders(uiOutput = plotOutput("plot"), type = "curtain", text = "Loading...")
    Output
      <div class="standby">
        <div id="loader" class="loader loader-curtain is-active standby-wait" data-curtain-text="Loading..."></div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

# loaders generates the correct HTML when type is smartphone

    Code
      loaders(uiOutput = plotOutput("plot"), type = "smartphone", text = "Loading...")
    Output
      <div class="standby">
        <div id="loader" class="loader loader-smartphone is-active standby-wait" data-screen="Loading..."></div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

