# glanceSpinners() generates the correct HTML

    Code
      glanceSpinners()
    Output
      <div class="standby">
        <div class="load1">
          <div class="loader"></div>
        </div>
      </div>

# spinners() generates the correct HTML

    Code
      spinners(uiOutput = plotOutput("plot"), type = 1, color = "#0275d8")
    Output
      <div class="standby">
        <div class="load1 standby-wait">
          <div class="loader"></div>
        </div>
        <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
      </div>

